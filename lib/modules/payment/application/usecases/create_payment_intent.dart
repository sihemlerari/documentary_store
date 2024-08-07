import '../payment_intent.dart';
import '../ports/payment_intent_provider.dart';

class CreatePaymentIntent {
  final PaymentIntentProvider _paymentIntentProvider;

  CreatePaymentIntent(this._paymentIntentProvider);

  Future<PaymentIntent> call(String documentaryId, String currency) {
    return _paymentIntentProvider.createPaymentIntent(documentaryId, currency);
  }
}
