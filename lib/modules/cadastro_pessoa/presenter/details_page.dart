import 'package:flutter/material.dart';

import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DetailsPage extends StatefulWidget {
  ResultPessoaModel pessoa;

  DetailsPage([
    this.pessoa,
    Key key,
  ]) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: const Color.fromRGBO(33, 70, 122, 1),
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ),
          SpeedDialChild(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(widget.pessoa.name),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 300,
            child: Image(
              image: AssetImage('assets/user.png'),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dados Pessoais",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("Nome: " + widget.pessoa.name),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Email: " + widget.pessoa.email),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Telefone: " + widget.pessoa.phone),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Data de nascimento: " + widget.pessoa.birthAt),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Data de criação do usuario: " + widget.pessoa.createdAt),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Data ultima atualização: " + widget.pessoa.updatedAt),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
