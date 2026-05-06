import 'package:go_router/go_router.dart';
import '../../features/product/presentation/pages/product_page.dart';
import '../../features/crypto/presentation/pages/crypto_page.dart';
import '../../features/bookmark/presentation/pages/bookmark_page.dart';
import '../../features/native/presentation/pages/native_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const ProductPage()),
      GoRoute(path: '/crypto', builder: (context, state) => const CryptoPage()),
      GoRoute(path: '/bookmark', builder: (context, state) => const BookmarkPage()),
      GoRoute(path: '/native', builder: (context, state) => const NativePage()),
    ],
  );
}