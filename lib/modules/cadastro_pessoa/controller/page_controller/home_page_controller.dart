import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/pessoa_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/states/states.dart'
    as state;

class HomePageController {
  static listPessoas(data) {
    if (data is state.ListPessoasSuccess) {
      PessoaController.inicializaPessoas((data).pessoas);
    } else if (data is state.Error) {
      return (data).error;
    }
  }
}
