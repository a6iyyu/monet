import 'package:logger/logger.dart';

/// A utility class for logging messages with different severity levels.
/// This class provides static methods to log messages as errors, warnings,
/// or informational messages.
///
/// Example usage:
/// ```dart
/// import 'package:monet/core/utils/logger.dart';
///
/// Log.info('This is an informational message.');
/// ```
class Log {
  Log._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      errorMethodCount: 5,
      lineLength: 50,
      methodCount: 0,
      printEmojis: true,
    ),
  );

  /// Logs an error message with optional error and stack trace.
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Logs an informational message.
  static void info(String message) {
    _logger.i(message);
  }

  /// Logs a warning message.
  static void warning(String message) {
    _logger.w(message);
  }
}