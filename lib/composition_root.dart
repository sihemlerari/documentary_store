import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'modules/documentary_catalog/infrastructure/documentary_detail_data_source_impl.dart';
import 'modules/documentary_catalog/infrastructure/documentary_summary_data_source_impl.dart';
import 'ui/core/auth/cubit/auth_cubit.dart';
import 'ui/documentaries/documentary_detail/cubit/documentary_detail_cubit.dart';
import 'ui/documentaries/home/cubit/documentaries_cubit.dart';

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

  // External
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => GoogleSignIn());
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
}
