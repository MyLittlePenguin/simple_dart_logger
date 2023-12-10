import 'package:simple_dart_logger/simple_dart_logger.dart';

/// Records of this type match [TermColor] to logLvls.
typedef ConsoleLogColors = ({
  TermColor trace,
  TermColor debug,
  TermColor info,
  TermColor warning,
  TermColor error,
});

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
  static const ConsoleLogColors defaultColors = (
    trace: TermColor.reset,
    debug: TermColor.reset,
    info: TermColor.reset,
    warning: TermColor.yellow,
    error: TermColor.red,
  );
  final ConsoleLogColors colors;

  /// This constructor creates a [ConsoleLogger] with a concrete configuration.
  /// If used inside a [MultiLogger] the [logLvl] and [className] properties
  /// will not be used. In that case the [ConsoleLogger.multi] constructor
  /// should be used.
  ConsoleLogger({
    super.logLvl,
    this.colorize = false,
    this.colors = defaultColors,
    required super.className,
  });

  /// This constructor lacks the very important [logLvl] and [className]
  /// properties. __Only use this constructor in combination with a
  /// [MultiLogger]!__
  factory ConsoleLogger.multi({
    bool colorize = false,
    ConsoleLogColors colors = defaultColors,
  }) =>
      ConsoleLogger(
        className: "",
        colorize: colorize,
        colors: colors,
      );

  @override
  void processLogMessage(String className, String logLvl, String msg) {
    if (!colorize) {
      super.processLogMessage(className, logLvl, msg);
      return;
    }

    final color = switch (logLvl) {
      "TRACE" => colors.trace,
      "DEBUG" => colors.debug,
      "INFO" => colors.info,
      "WARNING" => colors.warning,
      "ERROR" => colors.error,
      _ => TermColor.reset,
    };

    log(
      color.colorize(
        Logger.formatter(
          DateTime.now(),
          logLvl,
          className,
          msg,
        ),
      ),
    );
  }

  @override
  void log(String msg) {
    print(msg);
  }
}
