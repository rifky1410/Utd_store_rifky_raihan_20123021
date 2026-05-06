package com.example.utd_store_rifky_raihan_20123021 // Wajib sesuaikan dengan nama package folder Anda!

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    // Nama Channel ini HARUS SAMA PERSIS dengan yang ada di BatteryService.dart
    private val CHANNEL = "com.utd.store/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            // 1. Logika untuk mengambil persentase baterai
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Level baterai tidak tersedia.", null)
                }
            } 
            // 2. Logika untuk memunculkan pesan Toast Native
            else if (call.method == "showToast") {
                // Menangkap pesan yang dikirim dari Flutter (BatteryService.dart)
                val message = call.argument<String>("message")
                
                // Menampilkan Toast di layar Android
                Toast.makeText(this, message, Toast.LENGTH_LONG).show()
                result.success(null)
            } 
            else {
                result.notImplemented()
            }
        }
    }

    // Fungsi bawaan Android untuk membaca sensor baterai HP
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
    }
}