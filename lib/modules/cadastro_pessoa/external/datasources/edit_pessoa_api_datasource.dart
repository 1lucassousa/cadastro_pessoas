import 'package:cadastro_pessoas/modules/cadastro_pessoa/dev_homol_prod/path.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/datasources/edit_pessoa_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dio/dio.dart';

class EditPessoaApiDatasource implements EditPessoaDatasource {
  final Dio dio;

  EditPessoaApiDatasource(this.dio);

  @override
  Future<ResultPessoaModel> editPessoa(ResultPessoaModel pessoa) async {
    var url = domain + "/${pessoa.id}";

    print(url);

    final response = await dio.patch(url, data: pessoa.toJson());

    print(response.data);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final result = ResultPessoaModel.fromMap(response.data);

      return result;
    } else {
      throw DatasourceError();
    }
  }
}
