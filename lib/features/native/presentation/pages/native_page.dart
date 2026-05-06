import 'package:flutter/material.dart';
import '../../battery_service.dart';

class NativePage extends StatefulWidget {
  const NativePage({super.key});
  @override
  State<NativePage> createState() => _NativePageState();
}

class _NativePageState extends State<NativePage> {
  String _status = "Baterai belum dicek.";
  final _batteryService = BatteryService();

  Future<void> _checkBattery() async {
    try {
      final int level = await BatteryService.platform.invokeMethod('getBatteryLevel');
      setState(() => _status = "Persentase Baterai: $level%");
      await _batteryService.showBatteryAndToast();
    } catch (e) {
      setState(() => _status = "Gagal memanggil Native.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Integrasi Native Android"), backgroundColor: const Color(0xFF1A1A2E)),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: const Color(0xFF16213E), borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.android, size: 70, color: Colors.green),
              const SizedBox(height: 15),
              Text(_status, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: _checkBattery, child: const Text("Cek Baterai (Via Kotlin)")),
            ],
          ),
        ),
      ),
    );
  }
}