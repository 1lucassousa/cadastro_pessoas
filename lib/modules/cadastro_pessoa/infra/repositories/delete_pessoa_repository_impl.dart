import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/repositories/delete_pessoa_repository.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/datasources/delete_pessoa_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dartz/dartz.dart';

class DeletePessoaRepositoryImpl implements DeletePessoaRepository {
  final DeletePessoaDatasource datasource;

  DeletePessoaRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ResultPessoaModel>> deletePessoa(
      ResultPessoaModel pessoa) async {
    try {
      final result = await datasource.deletePessoa(pessoa);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    }
  }
}