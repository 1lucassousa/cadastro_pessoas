import 'package:cadastro_pessoas/modules/cadastro_pessoa/dev_homol_prod/path.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/datasources/list_pessoas_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dio/dio.dart';

class ListPessoasApiDatasource implements ListPessoasDatasource {
  final Dio dio;

  ListPessoasApiDatasource(this.dio);

  @override
  Future<List<ResultPessoaModel>> listPessoas() async {
    var url = domain;

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final list = (response.data as List)
          .map((e) => ResultPessoaModel.fromMap(e))
          .toList();

      return list;
    } else {
      throw DatasourceError();
    }
  }
}
