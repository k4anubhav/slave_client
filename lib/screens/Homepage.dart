import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:slave_client/BackgroundWork.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBgWorking = FlutterBackground.isBackgroundExecutionEnabled;

  void _changeBgWorkingState() async {
    _isBgWorking = FlutterBackground.isBackgroundExecutionEnabled;
    if (_isBgWorking) {
      BgWork.disableTimer();
      await FlutterBackground.disableBackgroundExecution();
    } else {
      const androidConfig = FlutterBackgroundAndroidConfig(
        notificationTitle: "Slave Client",
        notificationText: "Slave Client is running in the background",
        notificationImportance: AndroidNotificationImportance.Default,
      );
      var success =
          await FlutterBackground.initialize(androidConfig: androidConfig);
      if (success) await FlutterBackground.enableBackgroundExecution();
      BgWork.enableTimer();
    }
    _isBgWorking = FlutterBackground.isBackgroundExecutionEnabled;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slave Client'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Slave Client',
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _changeBgWorkingState,
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.black87,
                onSurface: Colors.white,
              ),
              child: Text(_isBgWorking ? 'Stop Background' : 'Start Background',
                  style: const TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
