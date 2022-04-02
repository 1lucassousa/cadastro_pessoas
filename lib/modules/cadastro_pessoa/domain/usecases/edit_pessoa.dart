import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/repositories/edit_pessoa_repository.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dartz/dartz.dart';

abstract class EditPessoa {
  Future<Either<Failure, ResultPessoaModel>> call(ResultPessoaModel pessoa);
}

class EditPessoaImpl implements EditPessoa {
  final EditPessoaRepository repository;

  EditPessoaImpl(this.repository);

  @override
  Future<Either<Failure, ResultPessoaModel>> call(
      ResultPessoaModel pessoa) async {
    if (pessoa == null) {
      return Left(InvalidError());
    }

    return repository.editPessoa(pessoa);
  }
}
