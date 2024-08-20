import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/order_summary/order_summary_cubit.dart';
import 'chargily_payment_button.dart';
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
          OrderSummaryLoaded() => _createPaymentButton(state.documentary.id),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _createPaymentButton(String documentaryId) {
    const paymentGateway = String.fromEnvironment('PAYMENT_GATEWAY');
    switch (paymentGateway) {
      case 'stripe':
        return StripePaymentButton(documentaryId: documentaryId, currency: 'usd');
      case 'chargily':
        return ChargilyPaymentButton(documentaryId: documentaryId);
      default:
        throw Exception('Invalid payment gateway configuration');
    }
  }
}
