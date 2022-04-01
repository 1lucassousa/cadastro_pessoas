import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/page_controller/details_page_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/pessoa_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/event/delete_pessoa_event.dart';
import 'package:flutter/material.dart';

import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/states/states.dart'
    as state;

class DetailsPage extends StatefulWidget {
  final ResultPessoaModel pessoa;

  const DetailsPage([
    this.pessoa,
    Key key,
  ]) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final eventDeletePessoa = Modular.get<DeletePessoaEvent>();

  ProgressDialog progressDialog;

  Future _eventDeletePessoa(ResultPessoaModel pessoa) async {
    return await eventDeletePessoa.eventToState(pessoa);
  }

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
              onPressed: () async {
                progressDialog =
                    ProgressDialog(context, type: ProgressDialogType.Normal);
                progressDialog.style(
                    message: "Carregando dados...",
                    progressWidget: const CircularProgressIndicator());

                await progressDialog.show();

                var request = await _eventDeletePessoa(widget.pessoa);

                var savePessoa = DeletePageController.deletePessoa(request);

                if (savePessoa == state.DeletePessoaSuccess) {
                  await progressDialog.hide();
                  _alert(context,
                      label: 'Sucesso!',
                      msg: PessoaController.pessoa.name +
                          ' cadastrado(a) com sucesso');
                }
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(widget.pessoa.name),
        actions: [
          IconButton(
            onPressed: () async {
              progressDialog =
                  ProgressDialog(context, type: ProgressDialogType.Normal);
              progressDialog.style(
                  message: "Carregando dados...",
                  progressWidget: const CircularProgressIndicator());

              await progressDialog.show();

              var request = await _eventDeletePessoa(widget.pessoa);

              var deletePessoa = DeletePageController.deletePessoa(request);

              if (deletePessoa == state.DeletePessoaSuccess) {
                await progressDialog.hide();
                _alert(context,
                    label: 'Sucesso!',
                    msg: PessoaController.pessoa.name +
                        ' removido(a) com sucesso');
              }
            },
            icon: const Icon(Icons.delete),
          )
        ],
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

  _alert(BuildContext context, {String label, String msg}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(label),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
