import 'dart:convert';

import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/external/datasources/list_pessoas_api_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../util/response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = ListPessoasApiDatasource(dio);

  test('Deve retornar uma lista de ResultPessoaModel', () async {
    when(dio.get(any)).thenAnswer((_) async =>
        Response(data: jsonDecode(listPessoasResponseResult), statusCode: 200));

    final future = datasource.listPessoas();

    expect(future, completes);
  });

  test('Deve retornar um DatasourceError se o codigo nao for 200', () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 404));

    final future = datasource.listPessoas();

    expect(future, throwsA(isA<DatasourceError>()));
  });
}
