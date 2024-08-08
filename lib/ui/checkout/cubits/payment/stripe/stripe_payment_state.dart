part of 'stripe_payment_cubit.dart';

sealed class StripePaymentState {
  const StripePaymentState();
}

final class PaymentInitial extends StripePaymentState {
  const PaymentInitial();
}

final class PaymentLoading extends StripePaymentState {
  const PaymentLoading();
}

final class PaymentSuccess extends StripePaymentState {
  const PaymentSuccess();
}

final class PaymentCancelled extends StripePaymentState {
  const PaymentCancelled();
}

final class PaymentError extends StripePaymentState {
  final String message;

  const PaymentError(this.message);
}
