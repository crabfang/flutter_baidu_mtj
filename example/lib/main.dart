import 'dart:async';

import 'package:baidu_mtj/baidu_mtj.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int count = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void _incrementCounter() {
    switch(count % 4) {
      case 0 :
        BaiduMtj.pageStart("PageName-Start");
        break;
      case 1 :
        BaiduMtj.pageEnd("PageName-End");
        break;
      case 2 :
        BaiduMtj.logEvent("eventId", eventLabel: "label");
        break;
      case 3 :
        BaiduMtj.logError("errorJson");
        break;
    }
    count++;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion = "";

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          )
      ),
    );
  }
}
