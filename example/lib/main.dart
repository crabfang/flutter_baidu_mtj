import 'dart:async';
import 'dart:io';
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
  String _tips = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void _incrementCounter() {
    Future<String> result;
    switch(count % 5) {
      case 0 :
        BaiduMtj.setChannel("FlutterChannel-$count");
        BaiduMtj.setDebug((count / 5) % 2 == 0);
        var appKey = Platform.isIOS ? "5a28e57b12" : "715e2e221c";
        result = BaiduMtj.startMtj(appKey);
        break;
      case 1 :
        result = BaiduMtj.pageStart("PageName");
        break;
      case 2 :
        result = BaiduMtj.pageEnd("PageName");
        break;
      case 3 :
        result = BaiduMtj.logEvent("eventId", eventLabel: "label");
        break;
      case 4:
        result = BaiduMtj.logError("errorJson");
        break;
    }
    result.then((result) {
      print(result);
      setState(() {
        _tips = result;
      });
    });
    count++;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
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
          child: Text('Running on: $_tips\n'),
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
