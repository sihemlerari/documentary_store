import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/order_summary/order_summary_cubit.dart';
import 'stripe_payment_button.dart';

class CheckoutFAB extends StatelessWidget {
  const CheckoutFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderSummaryCubit, OrderSummaryState>(
      builder: (context, state) {
        return switch (state) {
          OrderSummaryLoaded() =>
            StripePaymentButton(documentaryId: state.documentary.id, currency: 'usd'),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
