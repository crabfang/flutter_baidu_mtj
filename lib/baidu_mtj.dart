import 'dart:async';

import 'package:flutter/services.dart';

class BaiduMtj {
  static const MethodChannel _channel = const MethodChannel('BaiduMtj');

  static Future<String> setChannel(String channel) async {
    Map<String, Object> params = {"channel": channel};
    return await _channel.invokeMethod("SetChannel", params);
  }

  static Future<String> setUserId(String userId) async {
    Map<String, Object> params = {"userId": userId};
    return await _channel.invokeMethod("SetUserId", params);
  }

  static Future<String> setDebug(bool isDebug) async {
    Map<String, Object> params = {"isDebug": isDebug};
    return await _channel.invokeMethod("SetDebug", params);
  }

  static Future<String> startMtj(String appKey) async {
    Map<String, Object> params = {"appKey": appKey};
    return await _channel.invokeMethod("StartMtj", params);
  }

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
