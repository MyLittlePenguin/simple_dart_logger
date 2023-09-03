import 'logger_base.dart';

final class ConsoleLogger extends Logger {
  ConsoleLogger({
    super.logLvl,
    required super.className,
  });

  factory ConsoleLogger.multi() => ConsoleLogger(className: "");

  @override
  void log(String msg) {
    print(msg);
  }
}

