import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/repositories/edit_pessoa_repository.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/datasources/edit_pessoa_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dartz/dartz.dart';

class EditPessoaRepositoryImpl implements EditPessoaRepository {
  final EditPessoaDatasource datasource;

  EditPessoaRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ResultPessoaModel>> editPessoa(
      ResultPessoaModel pessoa) async {
    try {
      final result = await datasource.editPessoa(pessoa);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    }
  }
}
