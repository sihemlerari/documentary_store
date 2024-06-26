import 'package:documentary_store/modules/auth/domain/authentication_provider.dart';
import 'package:documentary_store/modules/auth/domain/oauth_credential.dart';
import 'package:flutter_test/flutter_test.dart';

class GoogleAuthenticationProviderStub implements GoogleAuthenticationProvider {
  OAuthenticationCredential? _credential;

  void setCredential(OAuthenticationCredential? credential) {
    _credential = credential;
  }

  @override
  Future<OAuthenticationCredential?> signIn() async => _credential;

  @override
  Future<void> signOut() async {
    _credential = null;
  }
}
