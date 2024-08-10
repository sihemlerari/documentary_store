import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../composition_root.dart';
import '../theme/sizes.dart';
import 'cubits/order_summary/order_summary_cubit.dart';
import 'widgets/checkout_fab.dart';
import 'widgets/delivery_information.dart';
import 'widgets/order_summary.dart';

class CheckoutScreen extends StatelessWidget {
  final String documentaryId;

  const CheckoutScreen({
    super.key,
    required this.documentaryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderSummaryCubit>(
        create: (context) => getIt<OrderSummaryCubit>()..loadOrderSummary(documentaryId),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Checkout'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.s16),
                child: Column(
                  children: [
                    const OrderSummary().animate().moveY(duration: 500.ms),
                    gapH16,
                    const DeliveryInformation().animate().moveY(duration: 500.ms),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: const CheckoutFAB(),
        ));
  }
}
