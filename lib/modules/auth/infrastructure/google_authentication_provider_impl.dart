import 'package:google_sign_in/google_sign_in.dart';

import '../domain/authentication_provider.dart';
import '../domain/oauth_credential.dart';

class GoogleAuthenticationProviderImpl implements GoogleAuthenticationProvider {
  final GoogleSignIn _googleSignIn;

  GoogleAuthenticationProviderImpl(this._googleSignIn);

  @override
  Future<OAuthenticationCredential?> signIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    return OAuthenticationCredential(
      provider: OAuthenticationProvider.google,
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
