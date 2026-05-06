import 'dart:async';

class SplashService {
  // Logika Personal: Delay persis 1 detik (Digit terakhir NIM: 20123021)
  // Aturan ETS: Delay diatur di level Service/Domain, bukan UI.
  Future<void> startAppDelay() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}