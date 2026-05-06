import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/product/data/product_remote_data_source.dart';
import '../../features/product/data/product_repository.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';
import '../../features/bookmark/data/isar_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // 1. Network
  locator.registerLazySingleton(() => Dio());

  // 2. Database
  locator.registerLazySingleton(() => IsarService());

  // 3. Data Source
  locator.registerLazySingleton(() => ProductRemoteDataSource(locator<Dio>()));

  // 4. Repository
  locator.registerLazySingleton(() => ProductRepository(locator<ProductRemoteDataSource>()));

  // 5. Cubit - Perbaikan: Berikan ProductRepository langsung ke ProductCubit
  locator.registerFactory(() => ProductCubit(locator<ProductRepository>()));
}