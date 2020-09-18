import 'package:logger/logger.dart';

final logger = Logger();

class LoggerApp {
  static void localLogWriter(String text, {bool isError = false}) {
    if (isError) {
      logger.e(text);
    } else {
      logger.d(text);
    }
  }
}
