import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Wajib untuk fungsi compute (Isolate)
import '../../data/crypto_service.dart';
import '../../domain/crypto_model.dart';

// 1. Fungsi Isolate (Top-level function)
// Harus berada di luar class agar bisa dijalankan di Isolate berbeda
double calculateCryptoTax(int iterations) {
  double total = 0;
  for (int i = 0; i < iterations; i++) {
    total += i;
  }
  return total;
}

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  final CryptoService _cryptoService = CryptoService();
  String _calculationResult = "";
  bool _isCalculating = false;

  @override
  void dispose() {
    _cryptoService.closeConnection(); // Menutup koneksi WebSocket saat keluar
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text("DIA Real-time Bitcoin", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.currency_bitcoin, size: 100, color: Colors.orange),
            const SizedBox(height: 10),
            const Text(
              "Harga BTC (DIA Data)",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            
            // Integrasi WebSocket untuk harga real-time
            StreamBuilder<CryptoModel>(
              stream: _cryptoService.cryptoStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "\$ ${snapshot.data!.price}",
                    style: const TextStyle(
                      color: Color(0xFF00F5D4),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return const CircularProgressIndicator(color: Color(0xFF00F5D4));
              },
            ),
            
            const SizedBox(height: 50),
            
            // Tombol Kalkulasi Pajak menggunakan Isolate
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00F5D4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: _isCalculating ? null : () async {
                    setState(() {
                      _isCalculating = true;
                      _calculationResult = "Sedang menghitung...";
                    });

                    // Logika Personal: Looping 21 * 10.000.000 (NPM 20123021)
                    // Menggunakan compute agar UI TIDAK FREEZE saat looping[cite: 1]
                    final result = await compute(calculateCryptoTax, 21 * 10000000);

                    setState(() {
                      _isCalculating = false;
                      _calculationResult = "Selesai! Hasil: ${result.toStringAsFixed(0)}";
                    });
                  },
                  child: _isCalculating 
                    ? const CircularProgressIndicator(color: Color(0xFF1A1A2E))
                    : const Text(
                        "Kalkulasi Pajak (Isolate)",
                        style: TextStyle(color: Color(0xFF1A1A2E), fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            Text(
              _calculationResult,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}