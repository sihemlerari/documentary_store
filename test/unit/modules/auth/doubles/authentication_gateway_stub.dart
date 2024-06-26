import 'package:documentary_store/modules/auth/domain/authentication_gateway.dart';
import 'package:documentary_store/modules/auth/domain/customer.dart';
import 'package:documentary_store/modules/auth/domain/oauth_credential.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthenticationGatewayStub implements AuthenticationGateway {
  final Map<OAuthenticationCredential, Customer> customers = {};
  Customer? _currentCustomer;

  void addCustomer(OAuthenticationCredential credential, Customer customer) {
    customers[credential] = customer;
  }

  void setCurrentCustomer(Customer? customer) {
    _currentCustomer = customer;
  }

  @override
  Future<Customer?> currentCustomer() async {
    return _currentCustomer;
  }

  @override
  Future<void> signInWithCredential(OAuthenticationCredential credential) async {
    _currentCustomer = customers[credential];
  }

  @override
  Future<void> signOut() async {
    _currentCustomer = null;
  }
}
