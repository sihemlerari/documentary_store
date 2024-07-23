import '../payment_intent.dart';

abstract interface class PaymentIntentProvider {
  Future<PaymentIntent> createPaymentIntent(double amount, String currency);
}
