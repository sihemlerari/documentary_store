import 'package:documentary_store/modules/payment/application/checkout_session.dart';
import 'package:documentary_store/modules/payment/application/ports/checkout_session_provider.dart';
import 'package:documentary_store/modules/payment/application/usecases/create_checkout_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const documentaryId = 'our_planet_id';
  const checkoutSession = CheckoutSession(
    checkoutUrl: 'https://pay.chargily.dz/test/checkouts/012345678/pay',
    successUrl: 'https://documentary-store.com/payments/success',
    failureUrl: 'https://documentary-store.com/payments/failure',
  );

  test('should create a payment intent with correct amount and currency', () async {
    final checkoutSessionProvider = CheckoutSessionProviderSpy(checkoutSession);
    final createCheckoutSession = CreateCheckoutSession(checkoutSessionProvider);

    final result = await createCheckoutSession(documentaryId);

    expect(result, checkoutSession);
    expect(checkoutSessionProvider.calledDocumentaryId, documentaryId);
    expect(checkoutSessionProvider.callCount, 1);
  });
}

class CheckoutSessionProviderSpy implements CheckoutSessionProvider {
  CheckoutSession checkoutSession;

  String? calledDocumentaryId;
  int callCount = 0;

  CheckoutSessionProviderSpy(this.checkoutSession);

  @override
  Future<CheckoutSession> createCheckoutSession(String documentaryId) async {
    calledDocumentaryId = documentaryId;
    callCount++;
    return checkoutSession;
  }
}
