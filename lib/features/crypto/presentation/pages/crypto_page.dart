import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../data/crypto_service.dart';
import '../../domain/crypto_model.dart';

double heavyLoop(int n) {
  double total = 0;
  for (int i = 0; i < n; i++) { total += i; }
  return total;
}

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});
  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  final _service = CryptoService();
  String _res = "Belum ada kalkulasi.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DIA Real-time Bitcoin"), backgroundColor: const Color(0xFF1A1A2E)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<CryptoModel>(
              stream: _service.cryptoStream,
              builder: (context, snap) {
                if (snap.hasData) return Text("\$ ${snap.data!.price}", style: const TextStyle(fontSize: 35, color: Colors.tealAccent, fontWeight: FontWeight.bold));
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                setState(() => _res = "Menghitung...");
                final val = await compute(heavyLoop, 21 * 10000000);
                setState(() => _res = "Hasil: $val");
              },
              child: const Text("Kalkulasi Pajak (Isolate)"),
            ),
            const SizedBox(height: 10),
            Text(_res, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}