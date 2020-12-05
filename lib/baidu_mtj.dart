import 'dart:async';

import 'package:flutter/services.dart';

class BaiduMtj {
  static const MethodChannel _channel = const MethodChannel('BaiduMtj');

  static Future<String> pageStart(String pageName) async {
    Map<String, Object> params = {"pageName": pageName};
    return await _channel.invokeMethod("PageStart", params);
  }

  static Future<String> pageEnd(String pageName) async {
    Map<String, Object> params = {"pageName": pageName};
    return await _channel.invokeMethod("PageEnd", params);
  }

  static Future<String> logEvent(String eventId, { String eventLabel, int acc, Map<String, String> attributes }) async {
    Map<String, Object> params = { "eventId": eventId };
    if(eventLabel != null) params["eventLabel"] = eventLabel;
    if(acc != null) params["acc"] = acc;
    if(attributes != null) params["attributes"] = attributes;
    return await _channel.invokeMethod("LogEvent", params);
  }

  static Future<String> logError(String errorData) async {
    Map<String, Object> params = {"errorData": errorData};
    return await _channel.invokeMethod("LogError", params);
  }
}
