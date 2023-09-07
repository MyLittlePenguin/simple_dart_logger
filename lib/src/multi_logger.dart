import 'logger_base.dart';

/// This [Logger] implementation doesn't actually write log messages anywhere.
/// Instead it let's the actual logging be handled by any number of other loggers.
/// It handles the [logLvl] and the [className] for all the [Logger] instances
/// inside [loggers].
final class MultiLogger extends Logger {
  final Iterable<Logger> _loggers;

  MultiLogger({
    required super.className,
    super.logLvl,
    required Iterable<Logger> loggers,
  }) : _loggers = loggers;

  @override
  void log(String msg) {
    for (var logger in _loggers) {
      logger.log(msg);
    }
  }
}
