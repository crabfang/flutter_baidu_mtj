import 'dart:async';

import 'package:flutter/services.dart';

class BaiduMtj {
  static const MethodChannel _channel = const MethodChannel('BaiduMtj');

  static void pageStart(String pageName) {
    Map<String, Object> params = {"pageName": pageName};
    _channel.invokeMethod("PageStart", params);
  }

  static void pageEnd(String pageName) {
    Map<String, Object> params = {"pageName": pageName};
    _channel.invokeMethod("PageEnd", params);
  }

  static void logEvent(String eventId, { String eventLabel, int acc, Map<String, String> attributes }) {
    Map<String, Object> params = { "eventId": eventId };
    if(eventLabel != null) params["eventLabel"] = eventLabel;
    if(acc != null) params["acc"] = acc;
    if(attributes != null) params["attributes"] = attributes;
    _channel.invokeMethod("LogEvent", params);
  }

  static void logError(String errorData) {
    Map<String, Object> params = {"errorData": errorData};
    _channel.invokeMethod("LogError", params);
  }
}
