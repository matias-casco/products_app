import 'package:products_app/core/http_client/exceptions/generic_exception.dart';

class NoInternetConnectionException extends GenericException {
  NoInternetConnectionException(
      {required super.requestOptions,
      super.readableOutput = 'No internet connection',
      super.returnMessage = 'No internet connection',
      super.code = ErrorCode.noInternetConnection});
}
