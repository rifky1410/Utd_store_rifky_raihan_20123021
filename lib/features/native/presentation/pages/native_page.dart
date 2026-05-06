import 'package:flutter/material.dart';
import '../../battery_service.dart';

class NativePage extends StatefulWidget {
  const NativePage({super.key});

  @override
  State<NativePage> createState() => _NativePageState();
}

class _NativePageState extends State<NativePage> {
  String _batteryStatus = "Baterai belum dicek.";
  final BatteryService _batteryService = BatteryService();

  Future<void> _handleGetBattery() async {
    try {
      // Mengambil data dari Kotlin
      final int level = await BatteryService.platform.invokeMethod('getBatteryLevel');
      
      setState(() {
        _batteryStatus = "Persentase Baterai: $level%";
      });
    } catch (e) {
      setState(() {
        _batteryStatus = "Gagal mengambil data baterai.";
      });
    }
  }

  Future<void> _handleShowToast() async {
    // Memanggil fungsi Toast yang ada di BatteryService
    await _batteryService.showBatteryAndToast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        // Mengubah judul AppBar menjadi Rifky Raihan
        title: const Text(
          "Rifky Raihan - Native", 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF16213E),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.android, size: 80, color: Color(0xFF3DDC84)),
              const SizedBox(height: 20),
              
              Text(
                _batteryStatus,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Tombol 1: Cek Baterai
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B61FF),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  icon: const Icon(Icons.battery_std, color: Colors.white),
                  label: const Text("Cek Baterai (Via Kotlin)", style: TextStyle(color: Colors.white)),
                  onPressed: _handleGetBattery,
                ),
              ),
              
              const SizedBox(height: 15),
              
              // Tombol 2: Munculkan Toast
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00F5D4),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF1A1A2E)),
                  label: const Text("Munculkan Native Toast", style: TextStyle(color: Color(0xFF1A1A2E))),
                  onPressed: _handleShowToast,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}