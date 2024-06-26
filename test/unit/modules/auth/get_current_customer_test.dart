import 'package:documentary_store/modules/auth/application/usecases/get_current_customer.dart';
import 'package:documentary_store/modules/auth/domain/customer.dart';
import 'package:flutter_test/flutter_test.dart';

import 'doubles/authentication_gateway_stub.dart';

void main() {
  late AuthenticationGatewayStub authenticationGateway;
  late GetCurrentCustomer getCurrentCustomer;

  const alice = Customer(id: 'aliceId', email: 'alice@gmail.dz');

  setUp(() {
    authenticationGateway = AuthenticationGatewayStub();
    getCurrentCustomer = GetCurrentCustomer(authenticationGateway);
  });

  test('should return the current authenticated customer', () async {
    authenticationGateway.setCurrentCustomer(alice);

    final currentCustomer = await getCurrentCustomer();

    expect(currentCustomer, isNotNull);
    expect(currentCustomer!.id, alice.id);
    expect(currentCustomer.email, alice.email);
  });
}
