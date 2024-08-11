import '../../shared/domain/domain_exception.dart';

class PaymentIntentCreationFailed extends DomainException {
  const PaymentIntentCreationFailed() : super('Payment intent creation failed');
}

class CheckoutSessionCreationFailed extends DomainException {
  const CheckoutSessionCreationFailed() : super('Checkout session creation failed');
}
