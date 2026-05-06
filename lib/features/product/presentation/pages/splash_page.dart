class SplashService {
  // Nama fungsi diubah menjadi startAppDelay agar dikenali oleh splash_page.dart
  Future<void> startAppDelay() async {
    // Menahan splash screen selama 1 detik sesuai aturan
    await Future.delayed(const Duration(seconds: 1)); 
  }
}