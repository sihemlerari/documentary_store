import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../composition_root.dart';
import '../../../modules/payment/application/checkout_session.dart';
import '../../core/widgets/snackbars.dart';
import '../../router.dart';
import '../cubits/payment/chargily/chargily_payment_cubit.dart';
import 'checkout_webview.dart';

class ChargilyPaymentButton extends StatelessWidget {
  final String documentaryId;

  const ChargilyPaymentButton({
    super.key,
    required this.documentaryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChargilyPaymentCubit>(
      create: (context) => getIt<ChargilyPaymentCubit>(),
      child: BlocConsumer<ChargilyPaymentCubit, ChargilyPaymentState>(
        listener: (context, state) {
          if (state is CheckoutSessionCreated) {
            _openWebView(context, state.checkoutSession);
          }

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
                    context.read<ChargilyPaymentCubit>().continueToPayment(documentaryId);
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

  void _openWebView(BuildContext context, CheckoutSession checkoutSession) {
    final paymentCubit = context.read<ChargilyPaymentCubit>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return CheckoutWebview(
            checkoutSession,
            onSuccessfullPayment: () {
              paymentCubit.onPaymentSuccess();
            },
            onFailedPayment: () {
              paymentCubit.onPaymentError();
            },
          );
        },
      ),
    );
  }
}
