import 'package:documentary_store/modules/auth/application/usecases/sign_out.dart';
import 'package:documentary_store/modules/auth/domain/customer.dart';
import 'package:flutter_test/flutter_test.dart';

import 'doubles/authentication_gateway_stub.dart';

void main() {
  late AuthenticationGatewayStub authenticationGateway;
  late SignOut signOut;

  const alice = Customer(id: 'aliceId', email: 'alice@gmail.dz');

  setUp(() {
    authenticationGateway = AuthenticationGatewayStub();
    signOut = SignOut(authenticationGateway);
  });

  test('should successfully sign out', () async {
    authenticationGateway.setCurrentCustomer(alice);

    await signOut();

    final currentCustomer = await authenticationGateway.currentCustomer();
    expect(currentCustomer, isNull);
  });
}
