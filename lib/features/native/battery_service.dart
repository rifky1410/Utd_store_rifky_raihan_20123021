import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class BatteryService {
  static const platform = MethodChannel('com.utd.store/native');

  Future<void> showBatteryAndToast() async {
    try {
      final int level = await platform.invokeMethod('getBatteryLevel');
      await platform.invokeMethod('showToast', {
        "message": "Baterai HP Purnama Raharja (Kel. 9): $level%"
      });
    } on PlatformException catch (e) {
      debugPrint("Native Error: ${e.message}");
    }
  }
}