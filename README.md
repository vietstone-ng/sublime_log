# sublime_log

[![pub package](https://img.shields.io/pub/v/sublime_log.svg)](https://pub.dev/packages/sublime_log)
[![pub points](https://img.shields.io/pub/points/sublime_log?color=2E8B57&label=pub%20points)](https://pub.dev/packages/sublime_log/score)
[![sublime_log](https://github.com/tusaamf/sublime_log/actions/workflows/sublime_log.yml/badge.svg)](https://github.com/tusaamf/sublime_log/actions/workflows/sublime_log.yml)

Save custom log message and view in application, share to other develop.

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :-----: |
|   ✅    | ✅  |  ✅   | ✅  |  ✅   |   ✅    |

# Usage

Import `package:sublime_log/sublime_log.dart`, and use the `SublimeLog.log` to log every information
you want.

Example:

```dart
import 'package:sublime_log/sublime_log.dart';

final message = 'Log message';
SublimeLog.log(message: message, tag: 'Label');
```

To view all the logs or share it to other.

```dart
import 'package:sublime_log/sublime_log.dart';

SublimeLog.showLogsPreview(
  context,
  quotes: [
    'First quote',
    'Second quote'
  ],
);
```

## Learn more

- [API Documentation](https://pub.dev/documentation/sublime_log/latest/sublime_log/sublime_log-library.html)
- [Plugin documentation website](https://plus.fluttercommunity.dev/docs/sublime_log/overview)