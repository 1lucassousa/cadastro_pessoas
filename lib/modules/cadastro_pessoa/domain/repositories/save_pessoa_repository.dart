import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dartz/dartz.dart';

abstract class SavePessoaRepository {
  Future<Either<Failure, ResultPessoaModel>> savePessoa(ResultPessoaModel pessoa);
}