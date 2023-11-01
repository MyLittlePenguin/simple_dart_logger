import 'package:simple_dart_logger/src/log_lvl.dart';

/// Formatter function that puts the log message String together.
typedef Formatter = String Function(
  DateTime timestamp,
  String logLvl,
  String className,
  String msg,
);

/// This abstract [Logger] provides an uniform interface for logging. It also
/// defines the [log] function that has to be implemented by all loggers.
abstract base class Logger {
  /// Defines what messages should actually appear in the log target.
  /// The predefined [LogLvl] can be used in any combination possible by using
  /// bitwise operations.
  final int logLvl;

  /// The name of the class that this [Logger] instance is used from.
  final String className;

  Logger({
    this.logLvl = LogLvl.all,
    required this.className,
  });

  static Logger Function(String className) _builder = (className) => NoLogger();

  /// Builder function used to define how to create the actual Logger instances.
  static set builder(Logger Function(String className) builder) {
    _builder = builder;
  }

  static Formatter formatter = (timestamp, logLvl, className, msg) {
    final tsStr = timestamp
        .toLocal()
        .toIso8601String()
        .replaceFirst("T", " ")
        .substring(0, 19);
    return "$tsStr $logLvl ($className): $msg";
  };

  /// Creates a [Logger] instance and uses the String representation of the
  /// runtimeType of [object] as the [className].
  factory Logger.createByObject(dynamic object) {
    return _builder(object.runtimeType.toString());
  }

  /// Creates a [Logger] instance.
  factory Logger.create(String className) {
    return _builder(className);
  }

  void trace(String msg) {
    if (checkLogLvl(LogLvl.trace)) {
      _log("TRACE", msg);
    }
  }

  void debug(String msg) {
    if (checkLogLvl(LogLvl.debug)) {
      _log("DEBUG", msg);
    }
  }

  void info(String msg) {
    if (checkLogLvl(LogLvl.info)) {
      _log("INFO", msg);
    }
  }

  void warning(String msg) {
    if (checkLogLvl(LogLvl.warning)) {
      _log("WARNING", msg);
    }
  }

  void error(String msg) {
    if (checkLogLvl(LogLvl.error)) {
      _log("ERROR", msg);
    }
  }

  void _log(String logLvl, String msg) {
    log(
      formatter(DateTime.now(), logLvl, className, msg),
    );
  }

  bool checkLogLvl(int logLvl) {
    return this.logLvl & logLvl == logLvl;
  }

  /// This function handels what should happen with the resulting log message.
  /// It is supposed to do the actual logging.
  void log(String msg);
}

/// This is a dummy Logger that doesn't log anything.
final class NoLogger extends Logger {
  NoLogger() : super(logLvl: 0, className: "");

  @override
  void log(String msg) {}
}
