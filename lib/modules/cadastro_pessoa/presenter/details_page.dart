import 'package:brasil_fields/brasil_fields.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/page_controller/details_page_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/pessoa_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/edit_page.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/event/delete_pessoa_event.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
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
    final nameController = TextEditingController(text: widget.pessoa.name);
    final emailController = TextEditingController(text: widget.pessoa.email);
    final phoneController = TextEditingController(text: widget.pessoa.phone);
    final birthController = TextEditingController(
        text: DetailsPageController.formatDate(widget.pessoa.birthAt));
    final createdController = TextEditingController(
        text: DetailsPageController.formatDate(widget.pessoa.createdAt));
    final updateController = TextEditingController(
        text: DetailsPageController.formatDate(widget.pessoa.updatedAt));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(33, 70, 122, 1),
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPage(widget.pessoa),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('Detalhes'),
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

              var deletePessoa = DetailsPageController.deletePessoa(request);

              if (deletePessoa == state.DeletePessoaSuccess) {
                await progressDialog.hide();
                _alert(context,
                    label: 'Sucesso!',
                    msg: PessoaController.pessoa.name +
                        ' foi removido(a) com sucesso');
              }
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 300,
              child: Image(
                image: AssetImage('assets/user.png'),
              ),
            ),
            _textFormField('Nome',
                controller: nameController, icon: Icons.people),
            const SizedBox(
              height: 10,
            ),
            _textFormField('Email',
                controller: emailController, icon: Icons.email),
            const SizedBox(
              height: 10,
            ),
            _textFormFieldTelefone('Telefone',
                controller: phoneController, icon: Icons.phone),
            const SizedBox(
              height: 10,
            ),
            _dateTimeField('Data de nascimento',
                controller: birthController, icon: Icons.calendar_today),
            const SizedBox(
              height: 10,
            ),
            _dateTimeField('Data de criação',
                controller: createdController, icon: Icons.calendar_today),
            const SizedBox(
              height: 10,
            ),
            _dateTimeField('Data da ultima atualização',
                controller: updateController, icon: Icons.calendar_today)
          ],
        ),
      ),
    );
  }

  _textFormField(String label,
      {TextEditingController controller, IconData icon}) {
    return TextFormField(
      enabled: false,
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelText: label,
      ),
    );
  }

  _textFormFieldTelefone(
    String label, {
    TextEditingController controller,
    IconData icon,
  }) {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TelefoneInputFormatter(),
      ],
      enabled: false,
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        labelText: label,
      ),
    );
  }

  _dateTimeField(String label,
      {TextEditingController controller, IconData icon}) {
    return DateTimeField(
      enabled: false,
      resetIcon: null,
      format: DateFormat("dd/MM/yyyy"),
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
        );
      },
      controller: controller,
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
                Navigator.pop(context, true);
              },
            )
          ],
        );
      },
    );
  }
}
