import 'dart:io';

import 'package:simple_dart_logger/simple_dart_logger.dart';

/// This [Logger] implementation writes the log messages to a file.
/// The [FileLogger] supports a log rotation. This means that if a log file 
/// reaches its current size limit it will be renamed and a new log file will be
/// written.
final class FileLogger extends Logger {
  /// This specifies where the log files will be written.
  Directory directory;
  /// This specifies the name of the log file. No matter what is specified as 
  /// [fileName] ".log" will be appended as file extension. If the log rotation
  /// is activated a ".0" will be inserted between the [fileName] and the file 
  /// extension. The older older the log file, the bigger the number.
  String fileName;
  /// This specifies the size limit of the log file. Since the log file is
  /// written by line, most log files will be slightly bigger than this limit.
  /// The next line will be written to a new file.
  FileSize maxSize;
  /// This defines the number of backup files in the log rotation.
  int backups;

  /// This creates a [FileLogger] with a concrete configuration. If used inside 
  /// a [MultiLogger] the [logLvl] and [className] properties will not be used.
  /// In that case the [FileLogger.multi] constructor should be used instead.
  FileLogger({
    required this.directory,
    required this.fileName,
    this.maxSize = const KiBytes(500),
    this.backups = 2,
    super.logLvl,
    required super.className,
  });

  /// This constructor lacks the very important [logLvl] and [className] 
  /// properties. __Only use this constructor in combination with a 
  /// [MultiLogger]!__
  factory FileLogger.multi({
    required Directory directory,
    required String fileName,
    FileSize maxSize = const KiBytes(500),
    int backups = 2,
  }) =>
      FileLogger(
        directory: directory,
        fileName: fileName,
        maxSize: maxSize,
        backups: backups,
        className: '',
      );

  @override
  void log(String msg) {
    _writeToFile(msg);
  }

  void _writeToFile(String msg) {
    var logFile = File(
        "${directory.path}/$fileName${backups > 0 ? '.0' : ''}.log");
    if (logFile.existsSync() && logFile.lengthSync() >= maxSize.bytes) {
      _renameFile(0);
    }
    logFile.writeAsStringSync("$msg\n", mode: FileMode.append);
  }

  void _renameFile(int arcNumber) {
    var nextArcNumber = arcNumber + 1;

    File file = File("${directory.path}/$fileName.$arcNumber.log");
    File newFile = File("${directory.path}/$fileName.$nextArcNumber.log");

    if (newFile.existsSync() && nextArcNumber <= backups) {
      _renameFile(nextArcNumber);
    }

    if (nextArcNumber <= backups) {
      file.renameSync(newFile.path);
    }
  }
}
