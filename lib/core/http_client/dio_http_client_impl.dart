import 'dart:async';

import 'package:dio/dio.dart';

import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/core/http_client/interceptors/internet_checker_interceptor.dart';
import 'package:products_app/core/http_client/status_code_validator.dart';
import 'package:products_app/core/logger/logger.dart';

class DioHttpClientImpl extends HttpClientInterface {
  DioHttpClientImpl({
    required Logger logger,
  }) : _logger = logger;

  static const StatusCodeValidator validator = StatusCodeValidator();

  final Logger _logger;

  Future<Dio> get dio async {
    final dio = await _createDio();
    dio.interceptors.add(InternetCheckerInterceptor());
    dio.interceptors.add(_logger.dioLogger);
    return dio;
  }

  Future<Dio> _createDio() async {
    return Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
        receiveTimeout: const Duration(minutes: 1),
        connectTimeout: const Duration(minutes: 1),
        contentType: 'application/json',
        receiveDataWhenStatusError: true,
        validateStatus: (int? status) {
          return status! > 0;
        },
      ),
    );
  }

  @override
  Future<T> getRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final myDio = await dio;

    final response = await myDio.get(
      url,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );

    validator.validate(response);

    return converter(response.data);
  }

  @override
  Future<T> postRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool isIsolate = true,
  }) async {
    final myDio = await dio;

    final response = await myDio.post(
      url,
      data: data,
      options: Options(headers: headers),
    );

    validator.validate(response);

    return converter(response.data);
  }

  @override
  Future<T> deleteRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? headers,
  }) async {
    final myDio = await dio;
    final response = await myDio.delete(
      url,
      options: Options(headers: headers),
    );
    validator.validate(response);

    return converter(response.data);
  }

  @override
  Future<T> putRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    final myDio = await dio;
    final response = await myDio.put(
      url,
      data: data,
      options: Options(headers: headers),
    );
    validator.validate(response);

    return converter(response.data);
  }
}
