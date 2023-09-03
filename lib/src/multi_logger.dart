import 'logger_base.dart';

final class MultiLogger extends Logger {
  final Iterable<Logger> _loggers;

  MultiLogger({
    required super.className,
    super.logLvl,
    required Iterable<Logger> loggers,
  }): _loggers = loggers;

  @override
  void log(String msg) {
    for(var logger in _loggers) {
      logger.log(msg);
    }
  }
}
