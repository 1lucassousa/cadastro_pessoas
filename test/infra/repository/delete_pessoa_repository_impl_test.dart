import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/datasources/delete_pessoa_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/repositories/delete_pessoa_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DeletePessoaDatasourceMock extends Mock
    implements DeletePessoaDatasource {}

main() {
  final datasource = DeletePessoaDatasourceMock();
  final repository = DeletePessoaRepositoryImpl(datasource);

  test("Deve retornar um ResultPessoaModel", () async {
    when(datasource.deletePessoa(any))
        .thenAnswer((_) async => ResultPessoaModel());

    ResultPessoaModel pessoa = ResultPessoaModel();

    final result = await repository.deletePessoa(pessoa);
    expect(result | null, isA<ResultPessoaModel>());
  });

  test("Deve retornar um DatasourceError quando datasource falhar", () async {
    when(datasource.deletePessoa(any)).thenThrow(DatasourceError());

    ResultPessoaModel pessoa = ResultPessoaModel();

    final result = await repository.deletePessoa(pessoa);

    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
