import 'dart:io';

import 'package:simple_dart_logger/simple_dart_logger.dart';

///////////////////////////////////////////////////////
// Simple example of how to configure a FileLogger
///////////////////////////////////////////////////////

void showConfigFileLogger() {
  Logger.builder = (className) => FileLogger(
        directory: Directory("log/"),
        fileName: "log_file",
        maxSize: KiBytes(500),
        backups: 2,
        logLvl: LogLvl.info | LogLvl.error | LogLvl.warning,
        className: className,
      );
}

///////////////////////////////////////////////////////
// How to get a logger instance and log something.
///////////////////////////////////////////////////////

void logSomething() {
  final logger = Logger.create("Some ClassName");
  logger.trace("some message");
}

///////////////////////////////////////////////////////
// How to create your own logger
///////////////////////////////////////////////////////

final class PrintLogger extends Logger {
  PrintLogger({
    super.logLvl,
    required super.className,
  });

  @override
  void log(String msg) {
    print(msg);
  }
}

void main() {
  Logger.builder = (className) => PrintLogger(
        logLvl: LogLvl.all,
        className: className,
      );
}
