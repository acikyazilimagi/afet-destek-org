import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLoggerImpl {
  AppLoggerImpl._();

  static final log = AppLoggerImpl._();

  final _log = Logger(
    printer: PrettyPrinter(
      printTime: true,
    ),
  );

  FutureOr<void> d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log.d(
      message,
      error,
      stackTrace,
    );
  }

  FutureOr<void> e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log.e(message, error, stackTrace);
    if (!kDebugMode) {
      // we can use crashlytics here if we need in future
    }
  }

  FutureOr<void> i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log.i(message, error, stackTrace);
  }
}
