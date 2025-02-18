typedef ResponseConverter<T> = T Function(dynamic response);

abstract class HttpClientInterface {

  Future<T> getRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isIsolate = true,
  });

  Future<T> postRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool isIsolate = true,
  });
  
  Future<T> putRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool isIsolate = true,
  });
  Future<T> deleteRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  });
}
