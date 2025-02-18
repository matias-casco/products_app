import 'package:equatable/equatable.dart';

import 'package:products_app/core/http_client/exceptions/exceptions.dart';

abstract class Failure extends Equatable {
  final ErrorCode? code;
  final String? message;
  final Map<String, dynamic>? parameters;

  const Failure({this.code, this.parameters, this.message});

  @override
  List<Object?> get props => [code, parameters, message];
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.code,
    super.parameters,
    super.message,
  });
}