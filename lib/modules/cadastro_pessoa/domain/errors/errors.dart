import 'package:cadastro_pessoas/modules/cadastro_pessoa/domain/entities/error.dart';

abstract class Failure implements Exception {}

class InvalidError implements Failure {}

class DatasourceError implements Failure {
  
  final ErrorData errorData;

  DatasourceError([this.errorData]);
  
}