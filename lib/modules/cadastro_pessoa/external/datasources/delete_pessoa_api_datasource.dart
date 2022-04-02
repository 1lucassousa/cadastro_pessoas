import 'package:cadastro_pessoas/modules/cadastro_pessoa/dev_homol_prod/path.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/datasources/delete_pessoa_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dio/dio.dart';

class DeletePessoaApiDatasource implements DeletePessoaDatasource {
  final Dio dio;

  DeletePessoaApiDatasource(this.dio);

  @override
  Future<ResultPessoaModel> deletePessoa(ResultPessoaModel pessoa) async {
    var url = domain + "/${pessoa.id}";

    final response = await dio.delete(url);

    if (response.statusCode == 204) {
      final result = pessoa;

      return result;
    } else {
      throw DatasourceError();
    }
  }
}
