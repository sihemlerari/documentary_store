import 'package:firebase_auth/firebase_auth.dart';

import '../domain/authentication_gateway.dart';
import '../domain/customer.dart';
import '../domain/oauth_credential.dart';
import 'firebase_auth_user_x.dart';

class AuthenticationGatewayImpl implements AuthenticationGateway {
  final FirebaseAuth _firebaseAuth;

  AuthenticationGatewayImpl(this._firebaseAuth);

  @override
  Future<Customer?> currentCustomer() async => _firebaseAuth.currentUser?.toCustomer();

  @override
  Future<void> signInWithCredential(OAuthenticationCredential credential) async {
    final OAuthCredential oAuthCredential = _oAuthCredential(credential);

    await _firebaseAuth.signInWithCredential(oAuthCredential);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  OAuthCredential _oAuthCredential(OAuthenticationCredential credential) {
    switch (credential.provider) {
      case OAuthenticationProvider.google:
        return GoogleAuthProvider.credential(
          accessToken: credential.accessToken,
          idToken: credential.idToken,
        );

      default:
        throw UnsupportedError('Unknown provider: ${credential.provider}');
    }
  }
}
