import 'package:dio/dio.dart';

abstract class GenericException extends DioException implements Exception {
  final String? readableOutput;
  final String? returnMessage;
  final ErrorCode? code;

  @override
  String toString() => '''
    $runtimeType: {
      readableOutput: $readableOutput,
      returnMessage: $returnMessage,
      code: $code,
    }
    ''';

  GenericException({
    this.readableOutput,
    this.returnMessage,
    this.code,
    required super.requestOptions,
  });

  static ErrorCode getErrorCodeFromString(String code) {
    switch (code) {
      case "OK":
        return ErrorCode.ok;
      case "UNEXPECTED":
        return ErrorCode.unexpected;
      case "BAD_REQUEST":
        return ErrorCode.badRequest;
      case "NO_INTERNET_CONNECTION":
      default:
        return ErrorCode.unknown;
    }
  }

  static String getStringFromErrorCode(ErrorCode errorCode) {
    switch (errorCode) {
      case ErrorCode.ok:
        return "OK";
      case ErrorCode.unexpected:
        return "UNEXPECTED";
      case ErrorCode.badRequest:
        return "BAD_REQUEST";
      case ErrorCode.noInternetConnection:
        return "NO_INTERNET_CONNECTION";
      default:
        return "UNKNOWN";
    }
  }
}

enum ErrorCode {
  ok,
  unexpected,
  unknown,
  badRequest,
  noInternetConnection,
}
