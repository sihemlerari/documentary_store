import 'package:cloud_functions/cloud_functions.dart';

import '../../shared/infrastructure/infrastructure_exception.dart';
import '../application/checkout_session.dart';
import '../application/payment_exception.dart';
import '../application/ports/checkout_session_provider.dart';

class ChargilyCheckoutSessionProvider implements CheckoutSessionProvider {
  final FirebaseFunctions _functions;

  ChargilyCheckoutSessionProvider(this._functions);

  @override
  Future<CheckoutSession> createCheckoutSession(String documentaryId) async {
    try {
      return await _tryCreateCheckoutSession(documentaryId);
    } on FirebaseFunctionsException catch (e) {
      if (e.code == 'unavailable') {
        throw const NetworkException();
      }
      if (e.code == 'deadline-exceeded') {
        throw const TimeoutException();
      }
      if (e.code == 'permission-denied') {
        throw const PermissionDeniedException();
      }
      if (e.code == 'internal') {
        throw const CheckoutSessionCreationFailed();
      }
      rethrow;
    }
  }

  Future<CheckoutSession> _tryCreateCheckoutSession(String documentaryId) async {
    HttpsCallable createCheckoutSession = _functions.httpsCallable('chargilyCreateCheckoutSession');
    final response = await createCheckoutSession(
      <String, dynamic>{
        'documentaryId': documentaryId,
      },
    );

    return _parseResponse(response);
  }

  CheckoutSession _parseResponse(HttpsCallableResult<dynamic> response) {
    if (response.data is! Map<String, dynamic>) {
      throw const CheckoutSessionCreationFailed();
    }

    final data = response.data as Map<String, dynamic>;
    final checkoutUrl = data['checkoutUrl'] as String?;

    if (checkoutUrl == null) {
      throw const CheckoutSessionCreationFailed();
    }

    return CheckoutSession(
      checkoutUrl: checkoutUrl,
      successUrl: data['successUrl'] as String,
      failureUrl: data['failureUrl'] as String,
    );
  }
}
