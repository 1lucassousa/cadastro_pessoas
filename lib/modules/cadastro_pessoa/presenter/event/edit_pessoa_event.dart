import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/usecases/edit_pessoa.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/states/states.dart';

class EditPessoaEvent {
  final EditPessoa usecase;

  EditPessoaEvent(this.usecase);

  Future eventToState(ResultPessoaModel pessoa) async {
    final result = await usecase(pessoa);

    return result.fold((l) => Error(l), (r) => EditPessoaSuccess(r));
  }
}
