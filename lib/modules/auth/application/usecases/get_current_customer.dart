import '../../domain/authentication_gateway.dart';
import '../../domain/customer.dart';

class GetCurrentCustomer {
  final AuthenticationGateway _authenticationGateway;

  GetCurrentCustomer(this._authenticationGateway);

  Future<Customer?> call() async {
    return await _authenticationGateway.currentCustomer();
  }
}
