import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/datasources/list_pessoas_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/repositories/list_pessoas_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ListPessoasDatasourceMock extends Mock implements ListPessoasDatasource {}

main() {
  final datasource = ListPessoasDatasourceMock();
  final repository = ListPessoasRepositoryImpl(datasource);

  test("Deve retornar uma lista de ResultPessoaModel", () async {
    when(datasource.listPessoas())
        .thenAnswer((_) async => <ResultPessoaModel>[]);

    final result = await repository.listPessoas();
    expect(result | null, isA<List<ResultPessoaModel>>());
  });

  test("Deve retornar um DatasourceError quando datasource falhar", () async {
    when(datasource.listPessoas()).thenThrow(DatasourceError());

    final result = await repository.listPessoas();

    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
