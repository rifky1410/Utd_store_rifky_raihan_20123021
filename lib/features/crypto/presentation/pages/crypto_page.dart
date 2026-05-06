import 'package:flutter/material.dart';
import '../../data/crypto_service.dart';
import '../../domain/crypto_model.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  late CryptoService _cryptoService;

  @override
  void initState() {
    super.initState();
    _cryptoService = CryptoService();
  }

  @override
  void dispose() {
    _cryptoService.closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Crypto Prices (WS)'),
        backgroundColor: Colors.orangeAccent.withValues(alpha: 0.3),
      ),
      body: Center(
        child: StreamBuilder<CryptoModel>(
          stream: _cryptoService.cryptoStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (!snapshot.hasData) return const CircularProgressIndicator();

            final data = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.currency_bitcoin, size: 80, color: Colors.orange),
                const SizedBox(height: 20),
                Text(data.symbol, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(
                  '\$${double.parse(data.price).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 40, color: Colors.green, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Data diperbarui secara otomatis via WebSocket', textAlign: TextAlign.center),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}