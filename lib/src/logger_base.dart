import 'package:simple_dart_logger/src/log_lvl.dart';

abstract base class Logger {
  final int logLvl;
  final String className;

  Logger({
    this.logLvl = LogLvl.all,
    required this.className,
  });

  static Logger Function(String className) _builder = (className) => NoLogger();

  static set builder(Logger Function(String className) builder) =>
      _builder = builder;

  factory Logger.createByObject(dynamic object) {
    return _builder(object.runtimeType.toString());
  }

  factory Logger.create(String className) {
    return _builder(className);
  }

  void trace(String msg) {
    if (_checkLogLvl(logLvl)) {
      _log("trace", msg);
    }
  }

  void debug(String msg) {
    if (_checkLogLvl(logLvl)) {
      _log("debug", msg);
    }
  }

  void info(String msg) {
    if (_checkLogLvl(logLvl)) {
      _log("info", msg);
    }
  }

  void warning(String msg) {
    if(_checkLogLvl(logLvl)) {
      _log("warning", msg);
    }
  }

  void error(String msg) {
    if (_checkLogLvl(logLvl)) {
      _log("error", msg);
    }
  }

  void _log(String logLvl, String msg) {
    var timestamp = DateTime.now()
        .toLocal()
        .toIso8601String()
        .replaceFirst("T", " ")
        .substring(0, 19);
    log("$timestamp $logLvl ($className): $msg");
  }

  bool _checkLogLvl(int logLvl) {
    return this.logLvl & logLvl == logLvl;
  }

  void log(String msg);
}

final class NoLogger extends Logger {
  NoLogger() : super(logLvl: 0, className: "");

  @override
  void log(String msg) {}
}
