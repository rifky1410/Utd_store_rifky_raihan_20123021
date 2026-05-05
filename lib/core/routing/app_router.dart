import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- IMPORT PRODUCT ---
import '../../features/product/presentation/pages/product_page.dart';
import '../../features/product/presentation/pages/splash_page.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';
import '../di/injection.dart';

// --- IMPORT BOOKMARK & CRYPTO ---
// Jika nama file atau folder Anda sedikit berbeda, ini yang biasanya bikin merah.
import '../../features/bookmark/bookmark_page.dart'; 
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
        builder: (context, state) {
          return BlocProvider(
            create: (context) => locator<ProductCubit>()..fetchAllProducts(),
            child: const ProductPage(),
          );
        },
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
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error 404')),
      body: const Center(child: Text('Halaman tidak ditemukan!')),
    ),
  );
}