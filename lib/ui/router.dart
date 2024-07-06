import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'checkout/checkout_screen.dart';
import 'core/auth/auth_guard.dart';
import 'documentaries/documentary_detail/documentary_detail_screen.dart';
import 'documentaries/home/home_screen.dart';
import 'login/login_screen.dart';
import 'orders/orders_screen.dart';

enum Routes {
  home,
  documentary,
  checkout,
  orders,
  login,
}

final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: Routes.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: Routes.documentary.name,
          path: 'documentary/:id',
          builder: (context, state) => DocumentaryDetailScreen(
            documentaryId: state.pathParameters['id']!,
          ),
          routes: [
            GoRoute(
              name: Routes.checkout.name,
              path: 'checkout',
              builder: (context, state) => const AuthGuard(child: CheckoutScreen()),
            ),
          ],
        ),
        GoRoute(
          name: Routes.orders.name,
          path: 'orders',
          builder: (context, state) => const AuthGuard(child: OrdersScreen()),
        ),
        GoRoute(
          name: Routes.login.name,
          path: 'login',
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            child: LoginScreen(
              goto: state.uri.queryParameters['goto'],
            ),
          ),
        ),
      ],
    ),
  ],
);
