import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/errors/errors.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';

abstract class State {}

class ListPessoasSuccess {
  final List<ResultPessoaModel> pessoas;

  ListPessoasSuccess(this.pessoas);
}

class SavePessoaSuccess {
  final ResultPessoaModel pessoa;

  SavePessoaSuccess(this.pessoa);
}

class DeletePessoaSuccess {
  final ResultPessoaModel pessoa;

  DeletePessoaSuccess(this.pessoa);
}

class Error implements State {
  final DatasourceError error;

  Error(this.error);
}