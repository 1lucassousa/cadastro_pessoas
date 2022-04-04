import 'dart:convert';

import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/external/datasources/edit_pessoa_api_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../util/response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = EditPessoaApiDatasource(dio);

  test('Deve retornar um ResultPessoaModel', () async {
    ResultPessoaModel pessoa = ResultPessoaModel(id: 115);

    when(dio.patch(any, data: pessoa.toJson())).thenAnswer((_) async =>
        Response(data: jsonDecode(savePessoaResponseResult), statusCode: 200));

    final future = datasource.editPessoa(pessoa);

    expect(future, completes);
  });

  test('Deve retornar um DatasourceError se o codigo nao for 200', () async {
    ResultPessoaModel pessoa = ResultPessoaModel(id: 115);

    when(dio.patch(any, data: pessoa.toJson()))
        .thenAnswer((_) async => Response(data: null, statusCode: 404));

    final future = datasource.editPessoa(pessoa);

    expect(future, throwsA(isA<DatasourceError>()));
  });
}
