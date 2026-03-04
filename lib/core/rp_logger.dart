import 'package:logger/logger.dart';

class RPLogger {
  static final _internalLogger = Logger(
    filter: ProductionFilter(),
    printer: PrettyPrinter(
      dateTimeFormat: (time) => time.toString(),
    ),
  );

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _internalLogger.e(
      _messageWithPrefix(message),
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _internalLogger.w(
      _messageWithPrefix(message),
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void info(String message) {
    _internalLogger.i(_messageWithPrefix(message), time: DateTime.now());
  }

  static String _messageWithPrefix(String value) => "RenderProtocol: $value";
}
