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
import 'ui/core/auth/cubit/auth_cubit.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  // Cubits
  getIt.registerFactory(() => AuthCubit(
        getIt<GetCurrentCustomer>(),
        getIt<SignInWithGoogle>(),
        getIt<SignOut>(),
      ));

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

  // Repositories & Gateways
  getIt.registerLazySingleton<AuthenticationGateway>(() => AuthenticationGatewayImpl(
        getIt<FirebaseAuth>(),
      ));
  getIt.registerLazySingleton<GoogleAuthenticationProvider>(() => GoogleAuthenticationProviderImpl(
        getIt<GoogleSignIn>(),
      ));

  // External
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => GoogleSignIn());
}
