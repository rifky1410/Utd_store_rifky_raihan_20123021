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
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Memanggil fungsi delay dari Service sesuai aturan ETS
    final splashService = locator<SplashService>();
    await splashService.startAppDelay();

    if (mounted) {
      // Menggunakan go_router untuk navigasi
      context.go('/product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            // Wajib menampilkan Nama dan NIM Rifky
            const Text(
              "UTD Store Rifky Raihan",
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: Colors.white
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "NPM: 20123021",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}