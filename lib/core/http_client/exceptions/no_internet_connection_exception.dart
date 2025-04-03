import 'package:dio/dio.dart';

class NoInternetConnectionException extends DioException implements Exception {
  NoInternetConnectionException({required super.requestOptions});
}
