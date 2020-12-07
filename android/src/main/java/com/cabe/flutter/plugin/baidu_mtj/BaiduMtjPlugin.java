package com.cabe.flutter.plugin.baidu_mtj;

import android.util.Log;

import androidx.annotation.NonNull;

import com.baidu.mobstat.StatService;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * BaiduMtjPlugin
 */
public class BaiduMtjPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private MethodChannel channel;
    private ActivityPluginBinding activityBinding = null;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "BaiduMtj");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull final Result result) {
        Map<String, Object> params = (Map<String, Object>) call.arguments;
        Log.d("BaiduMtj", call.method + ": " + params);
        switch (call.method) {
            case "StartMtj":
                setAppKey((String) params.get("appKey"));
                result.success("android start mtj");
                break;
            case "SetChannel":
                setChannel((String) params.get("channel"));
                result.success("android channel");
                break;
            case "SetUserId":
                setUserId((String) params.get("userId"));
                result.success("android userId");
                break;
            case "SetDebug":
                setDebug((boolean) params.get("isDebug"));
                result.success("android debug");
                break;
            case "PageStart":
                actionPageStart((String) params.get("pageName"));
                result.success("android start");
                break;
            case "PageEnd":
                actionPageEnd((String) params.get("pageName"));
                result.success("android end");
                break;
            case "LogEvent":
                actionLogEvent(params);
                result.success("android event");
                break;
            case "LogError":
                actionLogError((String) params.get("errorData"));
                result.success("android error");
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void setAppKey(String appKey) {
        StatService.setAppKey(appKey);
        StatService.start(activityBinding.getActivity());
    }

    private void setChannel(String channel) {
        StatService.setAppChannel(activityBinding.getActivity(), channel, true);
    }

    private void setUserId(String userId) {
        StatService.setUserId(activityBinding.getActivity(), userId);
    }

    private void setDebug(boolean isDebug) {
        StatService.setDebugOn(isDebug);
    }

    private void actionPageStart(String pageName) {
        StatService.onPageStart(activityBinding.getActivity(), pageName);
    }

    private void actionPageEnd(String pageName) {
        StatService.onPageEnd(activityBinding.getActivity(), pageName);
    }

    private void actionLogEvent(Map<String, Object> params) {
        String eventId = params.containsKey("eventId") ? (String) params.get("eventId") : "";
        String label = params.containsKey("eventLabel") ? (String) params.get("eventLabel") : "";
        int acc = 1;
        try {
            acc = params.containsKey("acc") ? (int) params.get("acc") : 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        Map<String, String> attributes = null;
        try {
            attributes = params.containsKey("attributes") ? (Map<String, String>) params.get("attributes") : null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        StatService.onEvent(activityBinding.getActivity(), eventId, label, acc, attributes) ;
    }

    private void actionLogError(String errorInfo) {
        StatService.recordException(activityBinding.getActivity(), new Throwable(errorInfo));
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activityBinding = binding;
    }

    @Override
    public void onDetachedFromActivity() {
        activityBinding = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
    }
}
