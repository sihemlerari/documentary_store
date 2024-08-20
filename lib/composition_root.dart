import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'modules/auth/application/usecases/get_current_customer.dart';
import 'modules/auth/application/usecases/sign_in_with_google.dart';
import 'modules/auth/application/usecases/sign_out.dart';
import 'modules/auth/domain/authentication_gateway.dart';
import 'modules/auth/domain/authentication_provider.dart';
import 'modules/auth/infrastructure/authentication_gateway_impl.dart';
import 'modules/auth/infrastructure/google_authentication_provider_impl.dart';
import 'modules/documentary_catalog/application/ports/documentary_detail_data_source.dart';
import 'modules/documentary_catalog/application/ports/documentary_summary_data_source.dart';
import 'modules/documentary_catalog/application/usecases/get_documentaries.dart';
import 'modules/documentary_catalog/application/usecases/get_documentary_detail.dart';
import 'modules/documentary_catalog/application/usecases/get_documentary_summary.dart';
import 'modules/documentary_catalog/infrastructure/documentary_detail_data_source_impl.dart';
import 'modules/documentary_catalog/infrastructure/documentary_summary_data_source_impl.dart';
import 'modules/orders/application/ports/order_summary_data_source.dart';
import 'modules/orders/application/usecases/get_orders.dart';
import 'modules/orders/infrastructure/order_summary_data_source_impl.dart';
import 'modules/payment/application/ports/checkout_session_provider.dart';
import 'modules/payment/application/ports/payment_intent_provider.dart';
import 'modules/payment/application/usecases/create_checkout_session.dart';
import 'modules/payment/application/usecases/create_payment_intent.dart';
import 'modules/payment/infrastructure/chargily_checkout_session_provider.dart';
import 'modules/payment/infrastructure/stripe_payment_intent_provider.dart';
import 'modules/shared/domain/clock/clock.dart';
import 'modules/shared/domain/clock/default_clock.dart';
import 'ui/checkout/cubits/order_summary/order_summary_cubit.dart';
import 'ui/checkout/cubits/payment/chargily/chargily_payment_cubit.dart';
import 'ui/checkout/cubits/payment/stripe/stripe_payment_cubit.dart';
import 'ui/core/auth/cubit/auth_cubit.dart';
import 'ui/documentaries/documentary_detail/cubit/documentary_detail_cubit.dart';
import 'ui/documentaries/home/cubit/documentaries_cubit.dart';
import 'ui/orders/cubit/orders_cubit.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  // Cubits
  getIt.registerFactory(() => AuthCubit(
        getIt<GetCurrentCustomer>(),
        getIt<SignInWithGoogle>(),
        getIt<SignOut>(),
      ));
  getIt.registerFactory(() => DocumentariesCubit(getIt<GetDocumentaries>()));
  getIt.registerFactory(() => DocumentaryDetailCubit(getIt<GetDocumentaryDetail>()));
  getIt.registerFactory(() => OrderSummaryCubit(getIt<GetDocumentarySummary>()));
  getIt.registerFactory(() => OrdersCubit(getIt<GetOrders>()));

  // Use cases
  getIt.registerLazySingleton(() => GetCurrentCustomer(getIt<AuthenticationGateway>()));
  getIt.registerLazySingleton(() => SignInWithGoogle(
        getIt<AuthenticationGateway>(),
        getIt<GoogleAuthenticationProvider>(),
      ));
  getIt.registerLazySingleton(() => SignOut(
        getIt<AuthenticationGateway>(),
        getIt<GoogleAuthenticationProvider>(),
      ));

  getIt.registerLazySingleton(() => GetDocumentaries(getIt<DocumentarySummaryDataSource>()));
  getIt.registerLazySingleton(() => GetDocumentaryDetail(getIt<DocumentaryDetailDataSource>()));
  getIt.registerLazySingleton(() => GetDocumentarySummary(getIt<DocumentarySummaryDataSource>()));

  getIt.registerLazySingleton(() => GetOrders(getIt<OrderSummaryDataSource>()));

  getIt.registerLazySingleton(() => CreatePaymentIntent(getIt<PaymentIntentProvider>()));
  getIt.registerLazySingleton(() => CreateCheckoutSession(getIt<CheckoutSessionProvider>()));

  // Repositories, Gateways & Data sources
  getIt.registerLazySingleton<AuthenticationGateway>(() => AuthenticationGatewayImpl(
        getIt<FirebaseAuth>(),
      ));
  getIt.registerLazySingleton<GoogleAuthenticationProvider>(() => GoogleAuthenticationProviderImpl(
        getIt<GoogleSignIn>(),
      ));

  getIt.registerLazySingleton<DocumentarySummaryDataSource>(() => DocumentarySummaryDataSourceImpl(
        getIt<FirebaseFirestore>(),
      ));
  getIt.registerLazySingleton<DocumentaryDetailDataSource>(() => DocumentaryDetailDataSourceImpl(
        getIt<FirebaseFirestore>(),
      ));

  getIt.registerLazySingleton<OrderSummaryDataSource>(() => OrderSummaryDataSourceImpl(
        getIt<FirebaseFirestore>(),
        getIt<Clock>(),
      ));

  // External
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => GoogleSignIn());
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseFunctions.instance);

  // Other
  getIt.registerLazySingleton<Clock>(() => DefaultClock());

  // Payment gateway specific dependencies
  const paymentGateway = String.fromEnvironment('PAYMENT_GATEWAY');
  if (paymentGateway == 'stripe') {
    _setupStripeDependencies();
  } else if (paymentGateway == 'chargily') {
    _setupChargilyDependencies();
  } else {
    throw Exception('Invalid payment gateway configuration');
  }
}

void _setupStripeDependencies() {
  getIt.registerFactory(() => StripePaymentCubit(getIt<CreatePaymentIntent>(), getIt<Stripe>()));
  getIt.registerLazySingleton<PaymentIntentProvider>(
      () => StripePaymentIntentProvider(getIt<FirebaseFunctions>()));

  Stripe.publishableKey = const String.fromEnvironment('STRIPE_PUBLISHABLE_KEY');
  getIt.registerLazySingleton(() => Stripe.instance);
}

void _setupChargilyDependencies() {
  getIt.registerFactory(() => ChargilyPaymentCubit(getIt<CreateCheckoutSession>()));
  getIt.registerLazySingleton<CheckoutSessionProvider>(
      () => ChargilyCheckoutSessionProvider(getIt<FirebaseFunctions>()));
}
