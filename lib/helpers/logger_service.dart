import 'package:logger/logger.dart';

class GameLogger {
  GameLogger._internal();

  static final GameLogger _instance = GameLogger._internal();

  factory GameLogger() => _instance;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  void d(String message) => _logger.d(message);
  void i(String message) => _logger.i(message);
  void w(String message) => _logger.w(message);
  void e(String message) => _logger.e(message);
}