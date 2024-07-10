import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../composition_root.dart';
import '../core/auth/cubit/auth_cubit.dart';
import '../theme/sizes.dart';
import 'cubit/orders_cubit.dart';
import 'widgets/order_list.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchased Documentaries'),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          return switch (authState) {
            Authenticated() => BlocProvider(
                create: (context) => getIt<OrdersCubit>()..loadOrders(authState.user.id),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.s16),
                    child: BlocBuilder<OrdersCubit, OrdersState>(
                      builder: (context, ordersState) {
                        return switch (ordersState) {
                          OrdersLoading() => const Center(child: CircularProgressIndicator()),
                          OrdersError() => Center(child: Text(ordersState.message)),
                          OrdersLoaded() => (ordersState.orders.isEmpty)
                              ? const Center(child: Text('No orders found'))
                              : OrderList(orders: ordersState.orders),
                        };
                      },
                    ),
                  ),
                ),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
