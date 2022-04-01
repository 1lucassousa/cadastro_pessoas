import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/usecases/delete_pessoa.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/usecases/save_pessoa.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/external/datasources/delete_pessoa_api_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/external/datasources/save_pessoa_api_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/repositories/delete_pessoa_repository_impl.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/repositories/save_pessoa_repository_impl.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/create_page.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/event/delete_pessoa_event.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/event/save_pessoa_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:cadastro_pessoas/app_widget.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/usecases/list_pessoas.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/external/datasources/list_pessoas_api_datasource.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/repositories/list_pessoas_repository_impl.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/details_page.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/event/list_pessoas_event.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/home_page.dart';

class AppModule extends MainModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => ListPessoasImpl(i())),
        Bind((i) => ListPessoasApiDatasource(i())),
        Bind((i) => ListPessoasRepositoryImpl(i())),
        Bind((i) => ListPessoasEvent(i())),
        Bind((i) => SavePessoaImpl(i())),
        Bind((i) => SavePessoaApiDatasource(i())),
        Bind((i) => SavePessoaRepositoryImpl(i())),
        Bind((i) => SavePessoaEvent(i())),
        Bind((i) => DeletePessoaImpl(i())),
        Bind((i) => DeletePessoaApiDatasource(i())),
        Bind((i) => DeletePessoaRepositoryImpl(i())),
        Bind((i) => DeletePessoaEvent(i())),
      ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => const HomePage()),
        ModularRouter('/', child: (_, __) => const DetailsPage()),
        ModularRouter('/', child: (_, __) => const CreatePage()),
      ];

  @override
  // TODO: implement bootstrap
  Widget get bootstrap => const AppWidget();
}
