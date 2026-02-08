import 'package:flutter/foundation.dart';

class Logger {
  /// Debug log
  static void d(String tag, String message) {
    if (kDebugMode) {
      // Only print in debug mode
      // You can also colorize console output if needed
      debugPrint('[DEBUG][$tag]: $message');
    }
  }

  /// Info log (always)
  static void i(String tag, String message) {
    debugPrint('[INFO][$tag]: $message');
  }

  /// Error log
  static void e(String tag, String message) {
    if (kDebugMode) {
      debugPrint('[ERROR][$tag]: $message');
    }
  }
}
