import '../../shared/domain/domain_exception.dart';

class PaymentIntentCreationFailed extends DomainException {
  const PaymentIntentCreationFailed() : super('Payment intent creation failed');
}
