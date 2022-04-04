import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/repositories/list_pessoas_repository.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/usecases/list_pessoas.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ListPessoasReposityMock extends Mock implements ListPessoasRepository {}

main() {
  final repository = ListPessoasReposityMock();
  final usecase = ListPessoasImpl(repository);

  test("Deve retornar uma lista de ResultPessoaModel", () async {
    when(repository.listPessoas())
        .thenAnswer((_) async => const Right(<ResultPessoaModel>[]));

    final result = await usecase();
    expect(result | null, isA<List<ResultPessoaModel>>());
  });
}
