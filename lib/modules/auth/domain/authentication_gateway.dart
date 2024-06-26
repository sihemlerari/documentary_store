import 'customer.dart';
import 'oauth_credential.dart';

abstract interface class AuthenticationGateway {
  Future<Customer?> currentCustomer();
  Future<void> signInWithCredential(OAuthenticationCredential credential);
  Future<void> signOut();
}
