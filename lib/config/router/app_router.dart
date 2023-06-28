import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteshop/config/router/app_router_notifier.dart';
import 'package:noteshop/features/auth/auth.dart';
import 'package:noteshop/features/auth/presentation/providers/auth_provider.dart';
import 'package:noteshop/features/products/presentation/screens/product_screen.dart';
import 'package:noteshop/features/products/products.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),

      GoRoute(
        path: '/product/:id',
        builder: (context, state) => ProductScreen(
          productId: state.pathParameters['id'] ?? 'no-id'
        ),
      ),
    ],

    redirect: (context, state) {

      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if(isGoingTo == '/splash' && authStatus == AuthStatus.checking) return null;

      if(authStatus == AuthStatus.notAuthenticated){
        if(isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if(authStatus == AuthStatus.autheticated) {
        if(isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash') return '/';
      }

      return null;
    },
  );
});
