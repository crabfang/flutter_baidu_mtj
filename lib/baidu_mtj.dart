
import 'dart:async';

import 'package:flutter/services.dart';

class BaiduMtj {
  static const MethodChannel _channel =
      const MethodChannel('baidu_mtj');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
