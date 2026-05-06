import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// --- IMPORT SERVICES ---
import '../../features/product/domain/splash_service.dart';
import '../../features/product/data/product_remote_data_source.dart';
import '../../features/product/data/product_repository.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';
import '../../features/bookmark/data/isar_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // 1. Network Client (Dio)
  // Aturan ETS: Dio wajib dipasang interceptor (Logger)
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(
    requestBody: true, 
    responseBody: true
  ));
  locator.registerLazySingleton(() => dio);

  // 2. Database (Isar)
  locator.registerLazySingleton(() => IsarService());

  // 3. Splash Service (BARU DIDAFTARKAN)
  // Sesuai aturan ETS: Mengatur delay 1 detik berdasarkan NIM
  locator.registerLazySingleton(() => SplashService());

  // 4. Data Source
  locator.registerLazySingleton(() => ProductRemoteDataSource(locator<Dio>()));

  // 5. Repository
  // Aturan ETS: Manipulasi data "[Diskon 10%]" dilakukan di sini
  locator.registerLazySingleton(() => ProductRepository(locator<ProductRemoteDataSource>()));

  // 6. State Management (Cubit)
  locator.registerFactory(() => ProductCubit(locator<ProductRepository>()));
}