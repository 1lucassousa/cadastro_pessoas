import 'dart:convert';

import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/entities/pessoa.dart';

class ResultPessoaModel extends Pessoa {

  final int id;
  final String name;
  final String email;
  final String phone;
  final String birthAt;
  final String createdAt;
  final String updatedAt;

  ResultPessoaModel({this.id, this.name, this.email, this.phone, this.birthAt, this.createdAt, this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'birth_at': birthAt,
    };
  }

  factory ResultPessoaModel.fromMap(Map<String, dynamic> map) {
    return ResultPessoaModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      birthAt: map['birth_at'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultPessoaModel.fromJson(String source) => ResultPessoaModel.fromMap(json.decode(source));
}
