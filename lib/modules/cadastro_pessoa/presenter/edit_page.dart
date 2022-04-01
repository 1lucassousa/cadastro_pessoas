import 'package:brasil_fields/brasil_fields.dart';
import 'package:cadastro_pessoas/modules/cadastro_pessoa/infra/models/result_pessoa_model.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  final ResultPessoaModel pessoa;

  const EditPage([this.pessoa, Key key]) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.pessoa.name);
    final emailController = TextEditingController(text: widget.pessoa.email);
    final phoneController = TextEditingController(text: widget.pessoa.phone);
    final birthController = TextEditingController(text: widget.pessoa.birthAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar usuário'),
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
}
