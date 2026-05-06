import 'package:flutter/foundation.dart'; // Wajib ditambahkan untuk debugPrint
import 'package:flutter/services.dart';

class BatteryService {
  // Nama channel harus sama persis dengan yang ada di MainActivity.kt
  static const platform = MethodChannel('com.utd.store/native');

  Future<void> showBatteryAndToast() async {
    try {
      // 1. Memanggil fungsi ambil baterai dari Native Kotlin
      final int result = await platform.invokeMethod('getBatteryLevel');
      
      // 2. Memunculkan Native Toast melalui Kotlin
      // Mencantumkan Nama & NPM Rifky Raihan (20123021)
      await platform.invokeMethod('showToast', {
        "message": "Baterai HP Rifky Raihan (20123021) saat ini: $result%"
      });
    } on PlatformException catch (e) {
      // SOLUSI: Menggunakan debugPrint sebagai pengganti print biasa[cite: 1]
      debugPrint("Gagal mengambil data native: '${e.message}'.");
    }
  }
}