import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../domain/splash_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _runSplashLogic();
  }

  Future<void> _runSplashLogic() async {
    // Memanggil mesin delay 1 detik dari layer Service (Syarat UTS terpenuhi)
    final splashService = locator<SplashService>();
    await splashService.executePersonalDelay();

    // Pindah ke halaman Katalog secara elegan tanpa bisa di-back
    if (mounted) {
      context.go('/product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        // Tampilan Menarik: Latar belakang gradien
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade800, Colors.teal.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.storefront, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'UTD Store',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            // Menampilkan Nama dan NIM (Syarat UTS)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Column(
                children: [
                  Text('Rifky Raihan', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('NIM: 20123021', style: TextStyle(fontSize: 16, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}