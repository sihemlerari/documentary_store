import '../../domain/authentication_gateway.dart';
import '../../domain/authentication_provider.dart';

class SignOut {
  final AuthenticationGateway _authenticationGateway;
  final GoogleAuthenticationProvider _googleAuthCredential;

  SignOut(this._authenticationGateway, this._googleAuthCredential);

  Future<void> call() async {
    Future.wait([
      _authenticationGateway.signOut(),
      _googleAuthCredential.signOut(),
    ]);
  }
}
