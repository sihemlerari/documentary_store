import '../payment_intent.dart';

abstract interface class PaymentIntentProvider {
  Future<PaymentIntent> createPaymentIntent(String documentaryId, String currency);
}
