<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

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

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
