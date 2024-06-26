import 'package:documentary_store/modules/auth/application/usecases/sign_in_with_google.dart';
import 'package:documentary_store/modules/auth/domain/customer.dart';
import 'package:documentary_store/modules/auth/domain/oauth_credential.dart';
import 'package:flutter_test/flutter_test.dart';

import 'doubles/authentication_gateway_stub.dart';
import 'doubles/google_authentication_provider_stub.dart';

void main() {
  late AuthenticationGatewayStub authenticationGateway;
  late GoogleAuthenticationProviderStub googleAuthenticationProvider;
  late SignInWithGoogle signInWithGoogle;

  const aliceCredential = OAuthenticationCredential(
    provider: OAuthenticationProvider.google,
    accessToken: 'aliceAccessToken',
    idToken: 'aliceIdToken',
  );

  const alice = Customer(id: 'aliceId', email: 'alice@gmail.com');

  setUp(() {
    authenticationGateway = AuthenticationGatewayStub();
    googleAuthenticationProvider = GoogleAuthenticationProviderStub();
    signInWithGoogle = SignInWithGoogle(authenticationGateway, googleAuthenticationProvider);
  });

  test('should successfully sign in with google', () async {
    authenticationGateway.addCustomer(aliceCredential, alice);
    googleAuthenticationProvider.setCredential(aliceCredential);

    await signInWithGoogle();

    final currentCustomer = await authenticationGateway.currentCustomer();
    expect(currentCustomer, isNotNull);
    expect(currentCustomer!.id, alice.id);
    expect(currentCustomer.email, alice.email);
  });

  test('should not sign in if google sign in fails', () async {
    googleAuthenticationProvider.setCredential(null);
    await signInWithGoogle();

    final currentCustomer = await authenticationGateway.currentCustomer();
    expect(currentCustomer, isNull);
  });
}
