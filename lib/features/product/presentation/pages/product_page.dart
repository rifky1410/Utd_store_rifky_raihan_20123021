import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTD Store Rifky Raihan'),
      ),
      body: const Center(
        child: Text('Katalog Produk Akan Tampil Di Sini'),
      ),
    );
  }
}