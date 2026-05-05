import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/product/presentation/pages/product_page.dart';
import '../../features/product/presentation/pages/splash_page.dart'; 

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/', 
    routes: [
      // Splash Screen menjadi halaman yang pertama kali muncul
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      // Halaman beranda katalog dipindah ke path /product
      GoRoute(
        path: '/product',
        builder: (context, state) => const ProductPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error 404')),
      body: const Center(child: Text('Halaman tidak ditemukan!')),
    ),
  );
}