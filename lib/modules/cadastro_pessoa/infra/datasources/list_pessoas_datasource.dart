import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';

abstract class ListPessoasDatasource {
  Future<List<ResultPessoaModel>> listPessoas();
}