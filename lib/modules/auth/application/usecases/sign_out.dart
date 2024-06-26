import '../../domain/authentication_gateway.dart';

class SignOut {
  final AuthenticationGateway _authenticationGateway;

  SignOut(this._authenticationGateway);

  Future<void> call() async {
    await _authenticationGateway.signOut();
  }
}
