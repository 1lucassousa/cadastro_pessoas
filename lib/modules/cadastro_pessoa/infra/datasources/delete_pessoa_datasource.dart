import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';

abstract class DeletePessoaDatasource {
  Future<ResultPessoaModel> deletePessoa(ResultPessoaModel pessoa);
}