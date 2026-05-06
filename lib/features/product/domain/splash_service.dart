import 'dart:async';

class SplashService {
  Future<void> initSplash() async {
    // Menahan splash screen selama 1 detik
    await Future.delayed(const Duration(seconds: 1)); 
  }
}