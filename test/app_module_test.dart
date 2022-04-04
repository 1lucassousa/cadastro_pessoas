import 'dart:convert';

import 'package:cadastro_pessoas/app_module.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/usecases/list_pessoas.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'modules/cadastro_pessoa/util/response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  initModule(AppModule(), changeBinds: [Bind<Dio>((i) => dio)]);

  test('Deve recuperar um usecase sem erro', () {
    final usecase = Modular.get<ListPessoas>();
    expect(usecase, isA<ListPessoasImpl>());
  });

  test('Deve trazer um UsuarioLogin', () async {
    when(dio.get(any)).thenAnswer((_) async =>
        Response(data: jsonDecode(listPessoasResponseResult), statusCode: 200));

    final usecase = Modular.get<ListPessoas>();
    final result = await usecase();

    expect(result | null, isA<List<ResultPessoaModel>>());
  });
}
