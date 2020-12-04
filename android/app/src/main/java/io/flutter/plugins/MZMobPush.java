package io.flutter.plugins;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MZMobPush implements EventChannel.StreamHandler, MethodChannel.MethodCallHandler {

    public static final String EventChannel = "MZMobPush_EventChannel";
    private static final String MethodChannel = "MZMobPush_MethodChannel";
    private static EventChannel eventChannel;
    private static MethodChannel methodChannel;
    public static EventChannel.EventSink eventSink;
    public static MZCallback mCallback;

    public static void registerWith(DartExecutor dartExecutor, final MZCallback callback) {
        mCallback = callback;
        eventChannel = new EventChannel(dartExecutor, EventChannel);
        methodChannel = new MethodChannel(dartExecutor, MethodChannel);
        if (eventChannel == null || methodChannel == null) {
            return;
        }
        methodChannel.setMethodCallHandler(new MZMobPush());
        eventChannel.setStreamHandler(new MZMobPush());
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("InitSuccess")) {

        }
        mCallback.initSuccess();
    }
}
