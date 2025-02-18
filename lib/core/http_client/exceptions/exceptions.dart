export 'generic_exception.dart';
import 'package:products_app/core/http_client/exceptions/generic_exception.dart';

class DefaultException extends GenericException {
  static const defaultReadableOutput =
      'An error occurred. Please try again later.';

  DefaultException({
    super.returnMessage,
    super.readableOutput = defaultReadableOutput,
    super.code,
  });
}

class BadRequestException extends GenericException {
  BadRequestException({
    super.readableOutput,
    super.returnMessage,
    super.code,
  });
}
