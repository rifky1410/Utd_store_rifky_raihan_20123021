import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class BatteryService {
  // Nama channel ini HARUS SAMA dengan yang di Kotlin
  static const platform = MethodChannel('com.utd.store/native');

  Future<void> showBatteryAndToast() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      await platform.invokeMethod('showToast', {
        // Pesan Toast
        "message": "Baterai HP Rifky Raihan (20123021): $result%"
      });
    } on PlatformException catch (e) {
      debugPrint("Gagal memanggil native: '${e.message}'.");
    }
  }
}