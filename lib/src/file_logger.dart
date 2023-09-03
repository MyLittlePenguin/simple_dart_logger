import 'dart:io';

import 'package:simple_dart_logger/simple_dart_logger.dart';

final class FileLogger extends Logger {
  Directory logDirectory;
  String logFileName;
  FileSize maxSize;
  int fileArchiveSize;

  FileLogger({
    required this.logDirectory,
    required this.logFileName,
    this.maxSize = const KiBytes(500),
    this.fileArchiveSize = 2,
    super.logLvl,
    required super.className,
  });

  factory FileLogger.multi({
    required Directory logDirectory,
    required String logFileName,
    FileSize maxSize = const KiBytes(500),
    int fileArchiveSize = 2,
  }) =>
      FileLogger(
        logDirectory: logDirectory,
        logFileName: logFileName,
        maxSize: maxSize,
        fileArchiveSize: fileArchiveSize,
        className: '',
      );

  @override
  void log(String msg) {
    _writeToFile(msg);
  }

  void _writeToFile(String msg) {
    var logFile = File(
        "${logDirectory.path}/$logFileName${fileArchiveSize > 0 ? '.0' : ''}.log");
    if (logFile.existsSync() && logFile.lengthSync() >= maxSize.bytes) {
      _renameFile(0);
    }
    logFile.writeAsStringSync("$msg\n", mode: FileMode.append);
  }

  void _renameFile(int arcNumber) {
    var nextArcNumber = arcNumber + 1;

    File file = File("${logDirectory.path}/$logFileName.$arcNumber.log");
    File newFile = File("${logDirectory.path}/$logFileName.$nextArcNumber.log");

    if (newFile.existsSync() && nextArcNumber <= fileArchiveSize) {
      _renameFile(nextArcNumber);
    }

    if (nextArcNumber <= fileArchiveSize) {
      file.renameSync(newFile.path);
    }
  }
}
