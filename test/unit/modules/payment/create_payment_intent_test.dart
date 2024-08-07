import 'package:documentary_store/modules/payment/application/payment_intent.dart';
import 'package:documentary_store/modules/payment/application/ports/payment_intent_provider.dart';
import 'package:documentary_store/modules/payment/application/usecases/create_payment_intent.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const documentaryId = 'our_planet_id';
  const currency = 'usd';

  test('should create a payment intent with correct documentaryId and currency', () async {
    const clientSecret = 'payment_intent_client_secret';
    final paymentIntentProvider = PaymentIntentProviderSpy(clientSecret);
    final createPaymentIntent = CreatePaymentIntent(paymentIntentProvider);

    final result = await createPaymentIntent(documentaryId, currency);

    expect(result.clientSecret, clientSecret);
    expect(paymentIntentProvider.calledDocumentaryId, documentaryId);
    expect(paymentIntentProvider.calledCurrency, currency);
    expect(paymentIntentProvider.callCount, 1);
  });
}

class PaymentIntentProviderSpy implements PaymentIntentProvider {
  String clientSecret;

  String? calledDocumentaryId;
  String? calledCurrency;
  int callCount = 0;

  PaymentIntentProviderSpy(this.clientSecret);

  @override
  Future<PaymentIntent> createPaymentIntent(String documentaryId, String currency) async {
    calledDocumentaryId = documentaryId;
    calledCurrency = currency;
    callCount++;
    return PaymentIntent(clientSecret: clientSecret);
  }
}
