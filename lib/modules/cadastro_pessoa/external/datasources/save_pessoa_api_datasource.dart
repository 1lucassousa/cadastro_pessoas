import 'package:cadastro_pessoas/modules/cadastro_pessoa/dev_homol_prod/path.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/datasources/save_pessoa_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dio/dio.dart';

class SavePessoaApiDatasource implements SavePessoaDatasource {
  final Dio dio;

  SavePessoaApiDatasource(this.dio);

  @override
  Future<ResultPessoaModel> savePessoa(ResultPessoaModel pessoa) async {
    var url = domain;

    final response = await dio.post(url, data: pessoa.toJson());

    if (response.statusCode == 201) {
      final result = ResultPessoaModel.fromMap(response.data);

      return result;
    } else {
      throw DatasourceError();
    }
  }
}
