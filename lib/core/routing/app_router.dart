import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/product/presentation/pages/product_page.dart';

class AppRouter {
  // Mendefinisikan konfigurasi Router utama
  static final router = GoRouter(
    initialLocation: '/', // Saat aplikasi dibuka, mulai dari path '/'
    routes: [
      GoRoute(
        path: '/', 
        builder: (context, state) => const ProductPage(),
      ),
    ],
    // errorBuilder akan terpanggil jika User membuka path yang tidak terdaftar
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error 404')),
      body: const Center(child: Text('Halaman tidak ditemukan!')),
    ),
  );
}