import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void debug(String message) {
    if (kDebugMode) {
      debugPrint("🐛 DEBUG: $message");
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      debugPrint("ℹ️ INFO: $message");
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      debugPrint("⚠️ WARNING: $message");
    }
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      debugPrint("❌ ERROR: $message");
      if (error != null) {
        debugPrint("Error Details: $error");
      }
      if (stackTrace != null) {
        debugPrint("StackTrace: $stackTrace");
      }
    }
  }
}

/*
Usage:
AppLogger.debug("Login Success");
 */
