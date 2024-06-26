import 'package:documentary_store/modules/auth/domain/authentication_provider.dart';
import 'package:documentary_store/modules/auth/domain/oauth_credential.dart';
import 'package:flutter_test/flutter_test.dart';

class GoogleAuthenticationProviderSpy implements GoogleAuthenticationProvider {
  bool signOutCalled = false;

  @override
  Future<OAuthenticationCredential?> signIn() {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    signOutCalled = true;
  }
}
