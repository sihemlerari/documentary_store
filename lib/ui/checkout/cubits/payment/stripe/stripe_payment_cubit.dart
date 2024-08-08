import 'package:bloc/bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../../modules/payment/application/usecases/create_payment_intent.dart';
import '../../../../../modules/shared/domain/domain_exception.dart';
import '../../../../../modules/shared/infrastructure/infrastructure_exception.dart';

part 'stripe_payment_state.dart';

class StripePaymentCubit extends Cubit<StripePaymentState> {
  final CreatePaymentIntent _createPaymentIntent;
  final Stripe _stripe;

  StripePaymentCubit(this._createPaymentIntent, this._stripe) : super(const PaymentInitial());

  Future<void> continueToPayment(String documentaryId, String currency) async {
    emit(const PaymentLoading());

    try {
      final paymentIntent = await _createPaymentIntent.call(documentaryId, currency);

      await _stripe.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent.clientSecret,
          merchantDisplayName: 'Documentary Store',
        ),
      );

      await _stripe.presentPaymentSheet();
      emit(const PaymentSuccess());
    } on DomainException catch (error) {
      emit(PaymentError(error.message));
    } on InfrastructureException catch (error) {
      emit(PaymentError(error.message));
    } on StripeException catch (error) {
      if (error.error.code == FailureCode.Canceled) {
        emit(const PaymentCancelled());
      } else {
        emit(
          PaymentError(
            error.error.message ?? 'An unknown error occurred during payment',
          ),
        );
      }
    }
  }
}
