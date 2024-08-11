import '../../../../../modules/payment/application/checkout_session.dart';
import '../../../../../modules/payment/application/usecases/create_checkout_session.dart';
import '../../../../core/base_cubit.dart';

part 'chargily_payment_state.dart';

class ChargilyPaymentCubit extends BaseCubit<ChargilyPaymentState> {
  final CreateCheckoutSession _createCheckoutSession;

  ChargilyPaymentCubit(this._createCheckoutSession) : super(const PaymentInitial());

  Future<void> continueToPayment(String documentaryId) async {
    emit(const PaymentLoading());

    execute(
      () => _createCheckoutSession.call(documentaryId),
      onSuccess: (checkoutSession) {
        emit(CheckoutSessionCreated(checkoutSession));
      },
      onFailure: (error) {
        emit(PaymentError(error));
      },
    );
  }

  void onPaymentSuccess() {
    emit(const PaymentSuccess());
  }

  void onPaymentError() {
    emit(const PaymentError('Payment failed'));
  }
}
