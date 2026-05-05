class SplashService {
  // LOGIKA PERSONAL ANTI-AI (Bobot 15%)
  // Menahan layar persis 1 detik (Karena digit terakhir NIM 20123021 adalah 1)
  // Dilakukan di layer Service/Domain, bukan di UI.
  Future<void> executePersonalDelay() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}