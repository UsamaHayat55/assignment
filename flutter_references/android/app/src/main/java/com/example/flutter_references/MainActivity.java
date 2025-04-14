package com.example.flutter_references;

import android.content.Intent;
import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.example.service/channel";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("startService")) {
                        Intent intent = new Intent(this, BackgroundService.class);
                        startService(intent);
                        result.success("Service Started");
                    }else if (call.method.equals("stopService")) {
                        Intent intent = new Intent(this, BackgroundService.class);
                        stopService(intent);
                        result.success("Service Stopped");
                    } else {
                        result.notImplemented();
                    }
                });
    }
}