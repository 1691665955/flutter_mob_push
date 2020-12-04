package com.mz.flutter_mob_push;

import android.content.Intent;
import android.os.Bundle;

import com.mob.pushsdk.MobPushUtils;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.MZCallback;
import io.flutter.plugins.MZMobPush;

public class MainActivity extends FlutterActivity  {

    private String data;

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MZMobPush.registerWith(flutterEngine.getDartExecutor(), new MZCallback() {
            @Override
            public void initSuccess() {
                if (data != null) {
                    MZMobPush.eventSink.success(data);
                }
            }
        });
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent intent = getIntent();
        data = MobPushUtils.parseSchemePluginPushIntent(intent).toString();
    }
}
