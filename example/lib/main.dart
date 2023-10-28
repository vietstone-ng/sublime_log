import 'package:flutter/material.dart';
import 'package:sublime_log/sublime_log.dart';

void main() => runApp(MaterialApp(home: const ExampleApp()));

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sublime log demo')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _inputController,
              textAlign: TextAlign.center,
            ),
            TextButton(onPressed: _addLog, child: Text('Add log')),
            TextButton(onPressed: _viewLog, child: Text('View Logs'))
          ],
        ),
      ),
    );
  }

  void _addLog() {
    FocusScope.of(context).requestFocus(new FocusNode());
    SublimeLog.log(message: _inputController.text.trim());
    _inputController.clear();
    const snackBar = SnackBar(
      content: Text(
          'Yay! Your text has been logged! Press `View Logs` to see logged text!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _viewLog() {
    SublimeLog.showLogsPreview(
      context,
      quotes: ['First quote', 'Second quote'],
    );
  }
}
