import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/pessoa_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/states/states.dart'
    as state;

class EditPageController {
  static savePessoa(data) {
    if (data is state.EditPessoaSuccess) {
      PessoaController.inicializaPessoa((data).pessoa);
      return state.EditPessoaSuccess;
    } else if (data is state.Error) {
      return (data).error;
    }
  }
}
