class SplashService {
  // LOGIKA PERSONAL: Delay 1 Detik (Digit terakhir NIM 20123021 adalah 1)
  Future<void> executePersonalDelay() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}