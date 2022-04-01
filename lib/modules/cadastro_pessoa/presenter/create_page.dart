import 'package:brasil_fields/brasil_fields.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/pessoa_controller.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/page_controller/create_page_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/event/save_pessoa_event.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/states/states.dart'
    as state;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final eventSavePessoa = Modular.get<SavePessoaEvent>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final birthController = TextEditingController();

  ProgressDialog progressDialog;

  Future _eventSavePessoa(ResultPessoaModel pessoa) async {
    return await eventSavePessoa.eventToState(pessoa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        actions: [
          TextButton(
            onPressed: () async {
              progressDialog =
                  ProgressDialog(context, type: ProgressDialogType.Normal);
              progressDialog.style(
                  message: "Carregando dados...",
                  progressWidget: const CircularProgressIndicator());

              await progressDialog.show();

              if (nameController.text.isEmpty) {
                await progressDialog.hide();
                _alert(context,
                    label: 'Alerta!',
                    msg: 'Você precisa definir o nome do usuário.');
              } else if (emailController.text.isEmpty) {
                await progressDialog.hide();
                _alert(context,
                    label: 'Alerta!',
                    msg: 'Você precisa definir o email do usuário.');
              } else if (phoneController.text.isEmpty) {
                await progressDialog.hide();
                _alert(context,
                    label: 'Alerta!',
                    msg: 'Você precisa definir o telefone do usuário.');
              } else if (birthController.text.isEmpty) {
                await progressDialog.hide();
                _alert(context,
                    label: 'Alerta!',
                    msg:
                        'Você precisa definir a data de nascimento do usuário.');
              } else {
                ResultPessoaModel pessoa = ResultPessoaModel(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    birthAt: birthController.text);

                var request = await _eventSavePessoa(pessoa);

                var savePessoa = CreatePageController.savePessoa(request);

                if (savePessoa == state.SavePessoaSuccess) {
                  await progressDialog.hide();
                  _alert(context, label: 'Sucesso!', msg: PessoaController.pessoa.name + ' cadastrado(a) com sucesso', save: true);
                }
              }
            },
            child: const Text(
              'Salvar',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            _textFormField('Nome', controller: nameController),
            const SizedBox(
              height: 10,
            ),
            _textFormField('Email', controller: emailController),
            const SizedBox(
              height: 10,
            ),
            _textFormFieldTelefone('Telefone', controller: phoneController),
            const SizedBox(
              height: 10,
            ),
            _dateTimeField('Data de nascimento', controller: birthController)
          ],
        ),
      ),
    );
  }

  _textFormField(
    String label, {
    TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
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
    FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TelefoneInputFormatter(),
      ],
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        labelText: label,
      ),
    );
  }

  _dateTimeField(
    String label, {
    TextEditingController controller,
  }) {
    return DateTimeField(
      format: DateFormat("dd/MM/yyyy"),
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
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

  _alert(BuildContext context, {String label, String msg, bool save}) {
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
                if (save == true) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              },
            )
          ],
        );
      },
    );
  }
}
