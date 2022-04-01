import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/repositories/list_pessoas_repository.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dartz/dartz.dart';

abstract class ListPessoas {
  Future<Either<Failure, List<ResultPessoaModel>>> call();
}

class ListPessoasImpl implements ListPessoas {
  final ListPessoasRepository repository;

  ListPessoasImpl(this.repository);

  @override
  Future<Either<Failure, List<ResultPessoaModel>>> call() async {
    return repository.listPessoas();
  }
}