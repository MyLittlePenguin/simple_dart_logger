import 'logger_base.dart';

/// This [Logger] implementation writes the log messages with a simple print
/// statement. You should take care not to log anything in production with it
/// that might be sensible.
final class ConsoleLogger extends Logger {
  /// This constructor creates a [ConsoleLogger] with a concrete configuration.
  /// If used inside a [MultiLogger] the [logLvl] and [className] properties
  /// will not be used. In that case the [ConsoleLogger.multi] constructor
  /// should be used.
  ConsoleLogger({
    super.logLvl,
    required super.className,
  });

  /// This constructor lacks the very important [logLvl] and [className]
  /// properties. __Only use this constructor in combination with a
  /// [MultiLogger]!__
  factory ConsoleLogger.multi() => ConsoleLogger(className: "");

  @override
  void log(String msg) {
    print(msg);
  }
}
