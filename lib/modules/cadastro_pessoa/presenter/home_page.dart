import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/event/list_pessoas_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/page_controller/home_page_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/pessoa_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/create_page.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventListPessoas = Modular.get<ListPessoasEvent>();

    Future _eventListPessoas() async {
      return await eventListPessoas.eventToState();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreatePage(),
                ),
              );
            },
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: FutureBuilder(
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsPage(PessoaController.pessoas[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}