import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dartz/dartz.dart';

abstract class EditPessoaRepository {
  Future<Either<Failure, ResultPessoaModel>> editPessoa(
      ResultPessoaModel pessoa);
}
