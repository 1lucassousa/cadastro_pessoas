import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/pessoa_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/states/states.dart'
    as state;

class DeletePageController {
  static savePessoa(data) {
    if (data is state.DeletePessoaSuccess) {
      PessoaController.inicializaPessoa((data).pessoa);
      return state.SavePessoaSuccess;
    } else if (data is state.Error) {
      return (data).error;
    }
  }
}