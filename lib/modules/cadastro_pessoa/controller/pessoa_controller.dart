import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';

class PessoaController {
  static List<ResultPessoaModel> pessoas;
  static ResultPessoaModel pessoa;

  static inicializaPessoas(List<ResultPessoaModel> data) {
    pessoas = data;
  }

  static inicializaPessoa(ResultPessoaModel data) {
    pessoa = data;
  }
}
