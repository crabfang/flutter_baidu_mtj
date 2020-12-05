package com.cabe.flutter.plugin.baidu_mtj_example;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.baidu.mobstat.StatService;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        StatService.setAuthorizedState(this,true);
        StatService.start(this);
    }
}
