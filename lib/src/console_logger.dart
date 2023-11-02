import 'package:simple_dart_logger/simple_dart_logger.dart';
import 'package:simple_dart_logger/src/log_lvl.dart';

import 'logger_base.dart';

/// This [Logger] implementation writes the log messages with a simple print
/// statement. You should take care not to log anything in production with it
/// that might be sensible.
final class ConsoleLogger extends Logger {
  /// if this parameter is set to true the output in the Console will be colored
  /// if the console supports ANSI color codes.
  ///
  /// Warnings will be yellow.
  /// Errors will be red.
  final bool colorize;

  /// This constructor creates a [ConsoleLogger] with a concrete configuration.
  /// If used inside a [MultiLogger] the [logLvl] and [className] properties
  /// will not be used. In that case the [ConsoleLogger.multi] constructor
  /// should be used.
  ConsoleLogger({
    super.logLvl,
    this.colorize = false,
    required super.className,
  });

  /// This constructor lacks the very important [logLvl] and [className]
  /// properties. __Only use this constructor in combination with a
  /// [MultiLogger]!__
  factory ConsoleLogger.multi([bool colorize = false]) => ConsoleLogger(
        className: "",
        colorize: colorize,
      );

  @override
  void error(String msg) {
    if (!colorize) {
      super.error(msg);
      return;
    }
    if (checkLogLvl(LogLvl.warning)) {
      log(
        TermColor.red.colorize(
          Logger.formatter(
            DateTime.now(),
            "ERROR",
            className,
            msg,
          ),
        ),
      );
    }
  }

  @override
  void warning(String msg) {
    if (!colorize) {
      super.warning(msg);
      return;
    }
    if (checkLogLvl(LogLvl.warning)) {
      log(
        TermColor.yellow.colorize(
          Logger.formatter(
            DateTime.now(),
            "WARNING",
            className,
            msg,
          ),
        ),
      );
    }
  }

  @override
  void log(String msg) {
    print(msg);
  }
}
