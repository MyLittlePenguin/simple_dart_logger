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
  factory ConsoleLogger.multi() => ConsoleLogger(className: "");

  @override
  void error(String msg) {
    logColored(msg, TermColor.red);
  }

  @override
  void warning(String msg) {
    logColored(msg, TermColor.yellow);
  }

  @override
  void log(String msg) {
    print(msg);
  }

  void logColored(String msg, TermColor color) {
    log("$color$msg${TermColor.reset}");
  }
}

/// Console codes for setting the foreground color.
final class TermColor {
  final int value;

  const TermColor._(this.value);

  static final _magic = "\x1b";

  static const reset = TermColor._(0);
  static const black = TermColor._(30);
  static const red = TermColor._(31);
  static const green = TermColor._(32);
  static const yellow = TermColor._(33);
  static const blue = TermColor._(34);
  static const magenta = TermColor._(35);
  static const cyan = TermColor._(36);
  static const lightGrey = TermColor._(37);

  @override
  String toString() {
    return "$_magic[${value}m";
  }
}
