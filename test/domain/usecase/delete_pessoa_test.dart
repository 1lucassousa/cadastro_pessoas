import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/repositories/delete_pessoa_repository.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/usecases/delete_pessoa.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DeletePessoaRepositoryMock extends Mock
    implements DeletePessoaRepository {}

main() {
  final repository = DeletePessoaRepositoryMock();
  final usecase = DeletePessoaImpl(repository);

  test("Deve retornar um ResultPessoaModel", () async {
    when(repository.deletePessoa(any))
        .thenAnswer((_) async => Right(ResultPessoaModel()));

    ResultPessoaModel pessoa = ResultPessoaModel();

    final result = await usecase(pessoa);
    expect(result | null, isA<ResultPessoaModel>());
  });

  test("Deve retornar um InvalidError quando parametro for nulo", () async {
    when(repository.deletePessoa(any))
        .thenAnswer((_) async => Right(ResultPessoaModel()));

    final result = await usecase(null);
    expect(result.fold(id, id), isA<Failure>());
  });
}
