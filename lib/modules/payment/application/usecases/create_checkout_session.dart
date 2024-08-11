import '../checkout_session.dart';
import '../ports/checkout_session_provider.dart';

class CreateCheckoutSession {
  final CheckoutSessionProvider _checkoutSessionProvider;

  CreateCheckoutSession(this._checkoutSessionProvider);

  Future<CheckoutSession> call(String documentaryId) async {
    return await _checkoutSessionProvider.createCheckoutSession(documentaryId);
  }
}
