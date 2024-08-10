import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../composition_root.dart';
import '../../core/widgets/snackbars.dart';
import '../../router.dart';
import '../cubits/payment/stripe/stripe_payment_cubit.dart';

class StripePaymentButton extends StatelessWidget {
  final String documentaryId;
  final String currency;

  const StripePaymentButton({
    super.key,
    required this.documentaryId,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StripePaymentCubit>(
      create: (context) => getIt<StripePaymentCubit>(),
      child: BlocConsumer<StripePaymentCubit, StripePaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SuccessSnackBar(
                context: context,
                message:
                    'Payment successful! A link to access your documentary will be sent to your email shortly',
              ),
            );

            context.goNamed(Routes.orders.name);
          }

          if (state is PaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackBar(
                context: context,
                message: state.message,
              ),
            );
          }
        },
        builder: (context, state) {
          return FloatingActionButton.extended(
            onPressed: state is PaymentLoading
                ? null
                : () {
                    context.read<StripePaymentCubit>().continueToPayment(documentaryId, currency);
                  },
            backgroundColor: state is PaymentLoading
                ? Theme.of(context).disabledColor
                : Theme.of(context).floatingActionButtonTheme.backgroundColor,
            label: state is PaymentLoading
                ? const CircularProgressIndicator()
                : const Text('Continue to Payment'),
          );
        },
      ),
    );
  }
}
