import '../checkout_session.dart';

abstract interface class CheckoutSessionProvider {
  Future<CheckoutSession> createCheckoutSession(String documentaryId);
}
