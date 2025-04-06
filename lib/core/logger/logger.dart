import 'dart:developer' as developer;

import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract interface class Logger {
  TalkerDioLogger get dioLogger;
}

class LoggerImpl implements Logger {
  final TalkerDioLogger _logger;

  LoggerImpl()
      : _logger = TalkerDioLogger(
          talker: Talker(
            logger: TalkerLogger(
              settings: TalkerLoggerSettings(enableColors: false),
              output: (String message) {
                for (final line in message.split('\n')) {

                  String cleanLine = line;

                  if (cleanLine.length > 120) {
                    cleanLine = '${line.substring(0, 120)}...';
                  }

                  developer.log(cleanLine);
                }
              },
            ),
          ),
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
            printResponseMessage: true,
            printRequestData: true,
            printResponseData: true,
          ),
        );

  @override
  TalkerDioLogger get dioLogger => _logger;
}
