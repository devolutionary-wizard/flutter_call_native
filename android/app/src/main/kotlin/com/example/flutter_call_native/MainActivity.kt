package com.example.flutter_call_native

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Build
import  android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import java.lang.reflect.Method

class MainActivity: FlutterActivity() {
    private val  CHANNEL  = "sample.example";
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler { call, result ->
            if(call.method == "getVersion"){
                result.success("Android: "+Build.VERSION.RELEASE);
            }else{
                result.notImplemented();
            }
        }
    }

}
