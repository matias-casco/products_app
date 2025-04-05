import 'dart:async';

import 'package:dio/dio.dart';

import 'package:products_app/core/http_client/http_client_interface.dart';
import 'package:products_app/core/http_client/interceptors/interceptors.dart';
import 'package:products_app/core/logger/logger.dart';

class DioHttpClientImpl extends HttpClientInterface {
  DioHttpClientImpl({
    required Logger logger,
    required ErrorInterceptor errorInterceptor,
    required InternetCheckerInterceptor internetCheckerInterceptor,
  })  : _logger = logger,
        _errorInterceptor = errorInterceptor,
        _internetCheckerInterceptor = internetCheckerInterceptor;

  final Logger _logger;
  final ErrorInterceptor _errorInterceptor;
  final InternetCheckerInterceptor _internetCheckerInterceptor;

  Future<Dio> get dio async {
    final dio = await _createDio();
    dio.interceptors.add(_logger.dioLogger);
    dio.interceptors.add(_internetCheckerInterceptor);
    dio.interceptors.add(_errorInterceptor);
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
    
    return converter(response.data);
  }
}
