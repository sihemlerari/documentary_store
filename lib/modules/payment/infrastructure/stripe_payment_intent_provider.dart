import 'package:cloud_functions/cloud_functions.dart';

import '../../shared/infrastructure/infrastructure_exception.dart';
import '../application/payment_exception.dart';
import '../application/payment_intent.dart';
import '../application/ports/payment_intent_provider.dart';

class StripePaymentIntentProvider implements PaymentIntentProvider {
  final FirebaseFunctions _functions;

  StripePaymentIntentProvider(this._functions);

  @override
  Future<PaymentIntent> createPaymentIntent(String documentaryId, String currency) async {
    try {
      return await _tryCreatePaymentIntent(documentaryId, currency);
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
        throw const PaymentIntentCreationFailed();
      }
      rethrow;
    }
  }

  Future<PaymentIntent> _tryCreatePaymentIntent(String documentaryId, String currency) async {
    HttpsCallable createPaymentIntent = _functions.httpsCallable('stripeCreatePaymentIntent');
    final response = await createPaymentIntent(
      <String, dynamic>{
        'documentaryId': documentaryId,
        'currency': currency,
      },
    );

    return _parseResponse(response);
  }

  PaymentIntent _parseResponse(HttpsCallableResult<dynamic> response) {
    if (response.data is! Map<String, dynamic>) {
      throw const PaymentIntentCreationFailed();
    }

    final data = response.data as Map<String, dynamic>;
    final clientSecret = data['clientSecret'] as String?;

    if (clientSecret == null) {
      throw const PaymentIntentCreationFailed();
    }

    return PaymentIntent(clientSecret: clientSecret);
  }
}
