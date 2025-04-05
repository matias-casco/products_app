import 'package:dio/dio.dart';

import 'package:products_app/core/http_client/exceptions/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response == null) {
      throw DefaultException(
        code: GenericException.getErrorCodeFromString('GENERIC_ERROR'),
        returnMessage: 'Status code ${err.response?.statusCode} ${err.message}',
      );
    }
    if ((err.response!.statusCode ?? 400) < 400) {
      return;
    }
    if ((err.response!.statusCode ?? 400) > 399 &&
        (err.response!.statusCode ?? 0) < 500) {
      if (err.response!.data is Map<String, dynamic>) {
        if (err.response!.statusCode == 400) {
          throw BadRequestException(
            code: GenericException.getErrorCodeFromString('BAD_REQUEST'),
            readableOutput: err.response!.data['messages'][0]['readableOutput'],
            returnMessage:
                'Status code ${err.response!.statusCode} ${err.response!.statusMessage}',
          );
        }

        if (err.response!.statusCode != 200) {
          throw DefaultException(
            code: GenericException.getErrorCodeFromString(
                err.response!.data['messages'][0]['code']),
            returnMessage:
                'Status code ${err.response!.statusCode} ${err.response!.statusMessage}',
          );
        }
      }
    }

    if (err.response!.statusCode! >= 500) {
      if (err.response!.statusCode == 503) {
        throw DefaultException(
          code: GenericException.getErrorCodeFromString('GENERIC_ERROR'),
          returnMessage:
              'Status code ${err.response!.statusCode} ${err.response!.statusMessage}',
        );
      }
    }

    return handler.next(err);
  }
}
