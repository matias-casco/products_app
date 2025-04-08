import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:products_app/core/http_client/exceptions/exceptions.dart';

class DioClientExceptionInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final RequestOptions request = err.requestOptions;
    final String method = request.method; // GET, POST, etc.
    final String url = request.uri.toString(); // URL completa
    final String requestId = request.headers['X-Request-Id'] ??
        'No request id'; // Headers de la solicitud

    await FirebaseCrashlytics.instance.recordError(
      err.runtimeType,
      StackTrace.fromString(err.toString()),
      reason: [
        'Error type: ${err.type}',
        'Endpoint: $method $url',
        'dio error: ${err.error}',
        'dio message: ${err.message}',
        'requestId: $requestId',
        // 'X-User $_userID',
      ],
      information: [
        'Error type: ${err.type}',
        'Endpoint: $method $url',
        'dio error: ${err.error}',
        'dio message: ${err.message}',
        'requestId: $requestId',
        // 'X-User $_userID',
      ],
    );

    _dioExceptionHandler(err, handler);

    // handler.next(err);
  }

  void _dioExceptionHandler(
    DioException e,
    ErrorInterceptorHandler handler,
  ) async {
    switch (e.type) {
      case DioExceptionType.badCertificate:
        handler.reject(
          HTTPClientException(
            code: ErrorCode.unexpected,
            readableOutput:
                'Ocurrió un error y no es posible avanzar con la solicitud en este momento.',
            returnMessage: 'Error de certificado',
            requestOptions: e.requestOptions,
          ),
        );
      case DioExceptionType.badResponse:
        handler.reject(
          HTTPClientException(
            code: ErrorCode.unexpected,
            readableOutput:
                'Ocurrió un error y no es posible avanzar con la solicitud en este momento.',
            returnMessage: 'Error en la respuesta',
            requestOptions: e.requestOptions,
          ),
        );
      case DioExceptionType.cancel:
        handler.reject(
          HTTPClientException(
            code: ErrorCode.unexpected,
            readableOutput: 'La solicitud fue cancelada.',
            returnMessage: 'Consulta cancelada',
            requestOptions: e.requestOptions,
          ),
        );
      case DioExceptionType.connectionError:
        handler.reject(
          HTTPClientException(
            code: ErrorCode.unexpected,
            readableOutput:
                'Ocurrió un error y no es posible avanzar con la solicitud en este momento.',
            returnMessage: 'Error de conexión',
            requestOptions: e.requestOptions,
          ),
        );
      case DioExceptionType.connectionTimeout:
        handler.reject(
          HTTPClientException(
            code: ErrorCode.unexpected,
            readableOutput:
                'No es posible avanzar con esta solicitud debido a que se ha superado el tiempo de respuesta.',
            returnMessage: 'Tiempo de conexión agotado',
            requestOptions: e.requestOptions,
          ),
        );
      case DioExceptionType.receiveTimeout:
        handler.reject(
          HTTPClientException(
            code: ErrorCode.unexpected,
            readableOutput:
                'No es posible avanzar con la solicitud en este momento debido a que no se ha obtenido una respuesta.',
            returnMessage: 'Tiempo de recepción agotado',
            requestOptions: e.requestOptions,
          ),
        );
      case DioExceptionType.sendTimeout:
        handler.reject(
          HTTPClientException(
            code: ErrorCode.unexpected,
            readableOutput:
                'No es posible avanzar con esta solicitud debido a que se ha superado el tiempo de respuesta.',
            returnMessage: 'Tiempo de envío agotado',
            requestOptions: e.requestOptions,
          ),
        );
      case DioExceptionType.unknown:
        handler.reject(
          HTTPClientException(
            code: ErrorCode.unexpected,
            readableOutput:
                'Ocurrió un error y no es posible avanzar con la solicitud en este momento.',
            returnMessage: 'Error desconocido',
            requestOptions: e.requestOptions,
          ),
        );
    }
  }
}
