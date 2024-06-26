import '../../domain/authentication_gateway.dart';
import '../../domain/authentication_provider.dart';

class SignInWithGoogle {
  final AuthenticationGateway _authenticationGateway;
  final GoogleAuthenticationProvider _googleAuthenticationProvider;

  SignInWithGoogle(this._authenticationGateway, this._googleAuthenticationProvider);

  Future<void> call() async {
    final googleCredential = await _googleAuthenticationProvider.signIn();

    if (googleCredential == null) {
      return;
    }

    await _authenticationGateway.signInWithCredential(googleCredential);
  }
}
