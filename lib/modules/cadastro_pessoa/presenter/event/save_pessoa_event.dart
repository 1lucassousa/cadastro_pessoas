import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/usecases/save_pessoa.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/states/states.dart';

class SavePessoaEvent {
  final SavePessoa usecase;

  SavePessoaEvent(this.usecase);

  Future eventToState(ResultPessoaModel pessoa) async {
    final result = await usecase(pessoa);

    return result.fold((l) => Error(l), (r) => SavePessoaSuccess(r));
  }
}