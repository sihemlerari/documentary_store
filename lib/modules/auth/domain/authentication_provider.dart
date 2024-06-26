import 'oauth_credential.dart';

abstract interface class GoogleAuthenticationProvider implements AuthenticationProvider {}

abstract interface class AuthenticationProvider {
  Future<OAuthenticationCredential?> signIn();
}
