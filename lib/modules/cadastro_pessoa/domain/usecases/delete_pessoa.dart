import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/repositories/delete_pessoa_repository.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dartz/dartz.dart';

abstract class DeletePessoa {
  Future<Either<Failure, ResultPessoaModel>> call(ResultPessoaModel pessoa);
}

class DeletePessoaImpl implements DeletePessoa {
  final DeletePessoaRepository repository;

  DeletePessoaImpl(this.repository);

  @override
  Future<Either<Failure, ResultPessoaModel>> call(ResultPessoaModel pessoa) async {
    if (pessoa == null) {
      return Left(InvalidError());
    }

    return repository.deletePessoa(pessoa);
  }

}