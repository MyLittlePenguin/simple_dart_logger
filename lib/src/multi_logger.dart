import 'logger_base.dart';

final class MultiLogger extends Logger {
  final Iterable<Logger> _loggers;

  MultiLogger({
    required Iterable<Logger> loggers,
    super.logLvl,
    required super.className,
  }): _loggers = loggers;

  @override
  void log(String msg) {
    for(var logger in _loggers) {
      logger.log(msg);
    }
  }
}
