import 'package:documentary_store/modules/auth/application/usecases/sign_out.dart';
import 'package:documentary_store/modules/auth/domain/customer.dart';
import 'package:flutter_test/flutter_test.dart';

import 'doubles/authentication_gateway_stub.dart';
import 'doubles/google_authentication_provider_spy.dart';

void main() {
  late AuthenticationGatewayStub authenticationGateway;
  late GoogleAuthenticationProviderSpy googleAuthenticationProvider;
  late SignOut signOut;

  const bob = Customer(id: 'bobId', email: 'bob@gmail.dz');

  setUp(() {
    authenticationGateway = AuthenticationGatewayStub();
    googleAuthenticationProvider = GoogleAuthenticationProviderSpy();
    signOut = SignOut(authenticationGateway, googleAuthenticationProvider);
  });

  test('should successfully sign out', () async {
    authenticationGateway.setCurrentCustomer(bob);

    await signOut();

    final currentCustomer = await authenticationGateway.currentCustomer();
    expect(currentCustomer, isNull);
    expect(googleAuthenticationProvider.signOutCalled, isTrue);
  });
}
