import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/repositories/save_pessoa_repository.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/datasources/save_pessoa_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';

class SavePessoaRepositoryImpl implements SavePessoaRepository {
  final SavePessoaDatasource datasource;

  SavePessoaRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ResultPessoaModel>> savePessoa(
      ResultPessoaModel pessoa) async {
    try {
      final result = await datasource.savePessoa(pessoa);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    }
  }
}
