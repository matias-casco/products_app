import 'package:dio/dio.dart';
import 'package:products_app/core/http_client/exceptions/exceptions.dart';

class StatusCodeValidator {

  static void validate(Response response) {
    if ((response.statusCode ?? 400) < 400) {
      return;
    }
    if ((response.statusCode ?? 400) > 399 &&
        (response.statusCode ?? 0) < 500) {
      if (response.data is Map<String, dynamic>) {
        if (response.statusCode == 400) {
          throw BadRequestException(
            code: GenericException.getErrorCodeFromString('BAD_REQUEST'),
            readableOutput: response.data['messages'][0]['readableOutput'],
            returnMessage: response.data['messages'][0]['returnMessage'],
          );
        }

        if (response.statusCode != 200) {
          throw DefaultException(
            code: GenericException.getErrorCodeFromString(
                response.data['messages'][0]['code']),
            returnMessage: response.data['messages'][0]['returnMessage'],
          );
        }
      }
    }

    if (response.statusCode! >= 500) {
      if (response.statusCode == 503) {
        throw DefaultException(
            code: GenericException.getErrorCodeFromString('GENERIC_ERROR'),
            returnMessage:
                'Status code ${response.statusCode} ${response.statusMessage}');
      }
    }
  }
}
