import 'package:get_it/get_it.dart';
import '../../features/product/domain/splash_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Mendaftarkan Splash Service agar bisa dipanggil oleh UI
  locator.registerLazySingleton<SplashService>(() => SplashService());
}