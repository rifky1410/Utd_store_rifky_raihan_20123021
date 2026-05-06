import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/product/domain/splash_service.dart';
import '../../features/product/data/product_remote_data_source.dart';
import '../../features/product/data/product_repository.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';
import '../../features/bookmark/data/isar_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // 1. Network
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  locator.registerLazySingleton(() => dio);

  // 2. Database
  locator.registerLazySingleton(() => IsarService());

  // 3. Service Splash
  locator.registerLazySingleton(() => SplashService());

  // 4. Data Source
  locator.registerLazySingleton(() => ProductRemoteDataSource(locator<Dio>()));
  
  // 5. Repository (Logika [Diskon 10%])
  locator.registerLazySingleton(() => ProductRepository(locator<ProductRemoteDataSource>()));

  // 6. Cubit (Wajib Factory agar UI reaktif)
  locator.registerFactory(() => ProductCubit(locator<ProductRepository>()));
}