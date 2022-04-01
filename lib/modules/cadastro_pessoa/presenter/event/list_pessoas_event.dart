import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/usecases/list_pessoas.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/states/states.dart';

class ListPessoasEvent {
  final ListPessoas usecase;

  ListPessoasEvent(this.usecase);

  Future eventToState() async {
    final result = await usecase();
    return result.fold((l) => Error(l), (r) => ListPessoasSuccess(r));
  }
}