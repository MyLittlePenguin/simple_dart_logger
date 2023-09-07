import 'package:simple_dart_logger/simple_dart_logger.dart';
import 'package:test/test.dart';

final class TestLogger extends Logger {
  String? lastLogMsg;

  TestLogger({
    super.logLvl,
    required super.className,
  });

  @override
  void log(String msg) {
    lastLogMsg = msg;
  }
}

late TestLogger _logger;

void main() {
  group('A group of tests', withAllLogLvlTesting);
  test("test without any LogLvl", testWithoutAnyLogLvl);
  test("test formatting", testFormatting);
}

void withAllLogLvlTesting() {
  _logger = TestLogger(
    logLvl: LogLvl.all,
    className: "WithAllLogLvls",
  );

  test("test trace with all LogLvls", testTrace);
  test("test debug with all LogLvls", testDebug);
  test("test info with all LogLvls", testInfo);
  test("test warning with all LogLvls", testWarning);
  test("test error with all LogLvls", testError);
}

void testTrace() {
  _logger.trace("something");
  expect(
    _logger.lastLogMsg?.substring(20),
    "TRACE (WithAllLogLvls): something",
  );
}

void testDebug() {
  _logger.debug("something");
  expect(
    _logger.lastLogMsg?.substring(20),
    "DEBUG (WithAllLogLvls): something",
  );
}

void testInfo() {
  _logger.info("something");
  expect(
    _logger.lastLogMsg?.substring(20),
    "INFO (WithAllLogLvls): something",
  );
}

void testWarning() {
  _logger.warning("something");
  expect(
    _logger.lastLogMsg?.substring(20),
    "WARNING (WithAllLogLvls): something",
  );
}

void testError() {
  _logger.error("something");
  expect(
    _logger.lastLogMsg?.substring(20),
    "ERROR (WithAllLogLvls): something",
  );
}

void testWithoutAnyLogLvl() {
  _logger = TestLogger(
    logLvl: 0,
    className: "WithoutAnything",
  );
  _logger.trace("");
  expect(_logger.lastLogMsg, null);
  _logger.debug("");
  expect(_logger.lastLogMsg, null);
  _logger.info("");
  expect(_logger.lastLogMsg, null);
  _logger.warning("");
  expect(_logger.lastLogMsg, null);
  _logger.error("");
  expect(_logger.lastLogMsg, null);
}

void testFormatting() {
  Logger.formatter =
      (timestamp, logLvl, className, msg) => "[$logLvl] ($className) {$msg}";
  _logger = TestLogger(
    logLvl: LogLvl.all,
    className: "Formatter",
  );
  _logger.trace("foo");
  expect(_logger.lastLogMsg, "[TRACE] (Formatter) {foo}");
}
