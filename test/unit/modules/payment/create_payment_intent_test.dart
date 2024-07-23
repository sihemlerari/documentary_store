import 'package:documentary_store/modules/payment/application/payment_intent.dart';
import 'package:documentary_store/modules/payment/application/ports/payment_intent_provider.dart';
import 'package:documentary_store/modules/payment/application/usecases/create_payment_intent.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const amount = 100.0;
  const currency = 'usd';

  test('should create a payment intent with correct amount and currency', () async {
    const clientSecret = 'payment_intent_client_secret';
    final paymentIntentProvider = PaymentIntentProviderSpy(clientSecret);
    final createPaymentIntent = CreatePaymentIntent(paymentIntentProvider);

    final result = await createPaymentIntent(amount, currency);

    expect(result.clientSecret, clientSecret);
    expect(paymentIntentProvider.calledAmount, amount);
    expect(paymentIntentProvider.calledCurrency, currency);
  });
}

class PaymentIntentProviderSpy implements PaymentIntentProvider {
  String clientSecret;

  double? calledAmount;
  String? calledCurrency;
  int callCount = 0;

  PaymentIntentProviderSpy(this.clientSecret);

  @override
  Future<PaymentIntent> createPaymentIntent(double amount, String currency) async {
    calledAmount = amount;
    calledCurrency = currency;
    return PaymentIntent(clientSecret);
  }
}
