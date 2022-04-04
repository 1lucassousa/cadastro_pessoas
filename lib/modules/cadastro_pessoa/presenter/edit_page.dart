import 'package:brasil_fields/brasil_fields.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/page_controller/details_page_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/page_controller/edit_page_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/controller/pessoa_controller.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/event/edit_pessoa_event.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/presenter/states/states.dart'
    as state;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class EditPage extends StatefulWidget {
  final ResultPessoaModel pessoa;

  const EditPage([this.pessoa, Key key]) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final eventEditPessoa = Modular.get<EditPessoaEvent>();

  ProgressDialog progressDialog;

  Future _eventEditPessoa(ResultPessoaModel pessoa) async {
    return await eventEditPessoa.eventToState(pessoa);
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.pessoa.name);
    final emailController = TextEditingController(text: widget.pessoa.email);
    final phoneController = TextEditingController(text: widget.pessoa.phone);
    final birthController = TextEditingController(
        text: DetailsPageController.formatDate(widget.pessoa.birthAt));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar usuário'),
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
                    id: widget.pessoa.id,
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    birthAt: birthController.text);

                var request = await _eventEditPessoa(pessoa);

                var savePessoa = EditPageController.savePessoa(request);

                if (savePessoa == state.EditPessoaSuccess) {
                  await progressDialog.hide();
                  _alert(context,
                      label: 'Sucesso!',
                      msg: PessoaController.pessoa.name +
                          ' atualizado(a) com sucesso',
                      save: true);
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
                controller: birthController, icon: Icons.calendar_today)
          ],
        ),
      ),
    );
  }

  _textFormField(String label,
      {TextEditingController controller, IconData icon}) {
    return TextFormField(
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
                  Navigator.pop(context, true);
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
