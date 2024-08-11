part of 'chargily_payment_cubit.dart';

sealed class ChargilyPaymentState {
  const ChargilyPaymentState();
}

final class PaymentInitial extends ChargilyPaymentState {
  const PaymentInitial();
}

final class PaymentLoading extends ChargilyPaymentState {
  const PaymentLoading();
}

final class CheckoutSessionCreated extends ChargilyPaymentState {
  final CheckoutSession checkoutSession;

  const CheckoutSessionCreated(this.checkoutSession);
}

final class PaymentSuccess extends ChargilyPaymentState {
  const PaymentSuccess();
}

final class PaymentError extends ChargilyPaymentState {
  final String message;

  const PaymentError(this.message);
}
