import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/event/list_pessoas_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/page_controller/home_page_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/pessoa_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/create_page.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final eventListPessoas = Modular.get<ListPessoasEvent>();

    Future _eventListPessoas() async {
      return await eventListPessoas.eventToState();
    }

    Future<void> _atualizaLista() async {
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreatePage(),
                ),
              );

              if (result == true) {
                _atualizaLista();
              }
            },
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _atualizaLista,
        child: FutureBuilder(
          future: Future(_eventListPessoas),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            HomePageController.listPessoas(snapshot.data);

            return ListView.builder(
              itemCount: PessoaController.pessoas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/user.png'),
                  ),
                  title: Text(PessoaController.pessoas[index].name),
                  subtitle: Text(PessoaController.pessoas[index].email),
                  contentPadding: const EdgeInsets.all(10),
                  onTap: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsPage(PessoaController.pessoas[index]),
                      ),
                    );

                    if (result == true) {
                      _atualizaLista();
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
