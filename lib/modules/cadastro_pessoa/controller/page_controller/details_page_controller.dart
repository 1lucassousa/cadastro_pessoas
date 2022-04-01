import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/pessoa_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/states/states.dart'
    as state;
import 'package:intl/intl.dart';

class DetailsPageController {
  static var outputFormatDate = DateFormat("yyyy-MM-dd");
  static var outputFormatDateHour = DateFormat('yyyy-MM-ddTHH:mm:ssZ');

  static deletePessoa(data) {
    if (data is state.DeletePessoaSuccess) {
      PessoaController.inicializaPessoa((data).pessoa);
      return state.DeletePessoaSuccess;
    } else if (data is state.Error) {
      return (data).error;
    }
  }

  static formatDate(String date) {
    var dateFormat = DateFormat('dd/MM/yyy');
    return dateFormat.format(outputFormatDate.parse(date));
  }

  static formatDateHour(String date) {
    var dateFormat = DateFormat('dd/MM/yyy HH:mm:ss');
    return dateFormat.format(outputFormatDateHour.parse(date));
  }
}
