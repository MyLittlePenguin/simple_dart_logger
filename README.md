This package aims at providing a simple abstract Logger that can be easily
extended by the user of the Package. It comes with few Logger implementations
that will probably take care of most common logging needs, like logging to a file,
to console or both. The way the logger behaves needs to be configured __once__
before it can be used everywhere.

## Features

This package provides the following features:

- a FileLogger with optional log rotation
- a ConsoleLogger
- an abstract Logger that can be extended by the user of this package to easily 
provide a custom logging target like a web-service or a database
- a MultiLogger that takes any number of any valid implementation of the abstract Logger,
enforces the logLvl and className properties on them and logs to all of the Logger implementations

## Getting started

```dart 
import 'package:simple_dart_logger/simple_dart_logger.dart';

void main() {
    Logger.builder = (className) => ConsoleLogger(
        className: className,
        logLvl: LogLvl.all,
    );
}

class SomeClass {
    late final _logger = Logger.createByObject(this);

    SomeClass();

    void someMethod() {
        _logger.trace("call to someMethod");
    }
}
```

## Usage

To use this logger you need to create a builder function that instantiates a concrete Logger.
__This builder function has to be defined only once.__ It will be used by the factory constructors
of the Logger class. This function not only defines which logger should be used but also how it 
is configured.

```dart 
Logger.builder = (className) => ConsoleLogger(
    className: className,
);
```

### Configure the Logger 

As you can see above you configure the Logger by defining the builder function. 
This package defines four loggers but you can just write your own and use it in the builder
definition.

The ConsoleLogger can already be seen in the example above. 
Still here is a more complete example with all the default options:

```dart
Logger.builder = (className) => ConsoleLogger(
    className: className,
    colorized: false,
    logLvl: LogLvl.all,
);
```

If you want your errors to be red and your warnings to be yellow you can set
the colorized flag to true. It won't affect anything else.

```dart
Logger.builder = (className) => ConsoleLogger(
    className: className,
    colorized: true,
    logLvl: LogLvl.all,
);
```

You even can configure the colors used to print the messages:

```dart
Logger.builder = (className) => ConsoleLogger(
    className: className,
    colorized: true,
    colors: (
        trace: TermColor.reset,
        debug: TermColor.reset,
        info: TermColor.green,
        warning: TermColor.yellow,
        error: TermColor.red,
    ),
);
```

The FileLogger can be used the following
way:

```dart
Logger.builder = (className) => FileLogger(
    directory: Directory("log/"),
    fileName: "log_file",
    maxSize: KBytes(500),
    backups: 2,
    logLvl: LogLvl.info | LogLvl.error | LogLvl.warning,
    className: className,
);
```
__Important:__ If you want to use the FileLogger in a mobile project (Android/iOS),
you should use the [path_provider](https://pub.dev/packages/path_provider) package to get a directory that you can use for
your log file.

```dart
import "package:path_provider/path_provider.dart";

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationDocumentsDirectory();

    Logger.builder = (className) => FileLogger(
        directory: dir,
        fileName: "log_file",
        maxSize: KBytes(500),
        backups: 2,
        logLvl: LogLvl.all ^ LogLvl.trace,
        className: className,
    );
}
```

The log level can be configured using a bit mask. The following predefined values
can be used and combined with bit operations in any way:

```dart
LogLvl.trace;
LogLvl.debug;
LogLvl.info;
LogLvl.warning;
LogLvl.error;

LogLvl.all;
```

If it is neccessary to combine multiple loggers you can use the MultiLogger.
This way you can log to more than one target.

```dart
Logger.builder = (className) => MultiLogger(
    className: className,
    logLvl: LogLvl.all,
    loggers: [
        ConsoleLogger.multi(),
        FileLogger.multi(
            directory: Directory("log/"),
            fileName: "simple_log",
            maxSize: const MBytes(500),
            backups: 5,
        ),
    ],
);
```

It is also possible to change the formatting of your messages.

```dart
Logger.formatter =
    (timestamp, logLvl, className, msg) => "[$logLvl] ($className) {$msg}";
```

### Instantiation

There are to factory constructors that you can use to instantiate a logger instance.
One takes a String which should be the name of the class in that you want to use the logger.
Of course you can use any string but it is meant to be a hint where the logging message was
triggered.

```dart
class SomeClass {
    final _logger = Logger.create("SomeClass");
}
```

A better option is to create a logger instance with the createByObject constructor.
It will use a string representation of the runtimetype from the object that is passed to it 
as the className property.

```dart 
class SomeClass {
    late final _logger = Logger.createByObject(this);
}
```

### Create custom logger

If you want to create your own custom Logger that's very easy. You create your 
own class that extends the abstract Logger and implement the log function.

```dart 
final class DebugPrintLogger extends Logger {
  PrintLogger({
    super.logLvl,
    required super.className,
  });

  @override
  void log(String msg) {
    debugPrint(msg);
  }
}

void main() {
  Logger.builder = (className) => DebugPrintLogger(
     logLvl: LogLvl.all,
      className: className,
    );
  final logger = Logger.create("SomeName");    
  logger.debug("some message");
}
```

<!-- ## Additional information -->
