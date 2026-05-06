import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/product/presentation/pages/product_page.dart';
import '../../features/product/presentation/pages/splash_page.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';
import '../di/injection.dart';
import '../../features/bookmark/presentation/pages/bookmark_page.dart';
import '../../features/crypto/presentation/pages/crypto_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/product',
        builder: (context, state) => BlocProvider(
          // PENTING: Menambahkan ..fetchAllProducts() agar loading langsung jalan
          create: (context) => locator<ProductCubit>()..fetchAllProducts(),
          child: const ProductPage(),
        ),
      ),
      GoRoute(
        path: '/bookmark',
        builder: (context, state) => const BookmarkPage(),
      ),
      GoRoute(
        path: '/crypto',
        builder: (context, state) => const CryptoPage(),
      ),
    ],
  );
}