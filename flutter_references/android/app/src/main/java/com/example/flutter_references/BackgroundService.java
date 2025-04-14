package com.example.flutter_references;

import static android.content.ContentValues.TAG;

import android.app.Service;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;

public class BackgroundService extends Service {

    private Handler handler;
    private Runnable runnable;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {

        handler = new Handler(Looper.getMainLooper()); // For Toast on main thread

        runnable = new Runnable() {
            int count = 0;

            @Override
            public void run() {
                Toast.makeText(getApplicationContext(), "Toast #" + count++, Toast.LENGTH_SHORT).show();
                handler.postDelayed(this, 5000); // Repeat every 1 second
            }
        };

        handler.post(runnable); // Start loop

        return START_STICKY;
    }

    @Override
    public IBinder onBind(Intent intent) {
        // We don't need binding in this case, so return null
        return null;
    }

    @Override
    public void onDestroy() {
        if (handler != null && runnable != null) {
            handler.removeCallbacks(runnable); // Stop loop
        }
        super.onDestroy();
    }
}