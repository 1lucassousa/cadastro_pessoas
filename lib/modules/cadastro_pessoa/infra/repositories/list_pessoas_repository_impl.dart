import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/repositories/list_pessoas_repository.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/datasources/list_pessoas_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';

class ListPessoasRepositoryImpl implements ListPessoasRepository {
  final ListPessoasDatasource datasource;

  ListPessoasRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<ResultPessoaModel>>> listPessoas() async {
    try {
      final result =  await datasource.listPessoas();
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    }
  }
  
}