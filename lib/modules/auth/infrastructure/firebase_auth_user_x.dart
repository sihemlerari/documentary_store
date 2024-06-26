import 'package:firebase_auth/firebase_auth.dart';

import '../domain/customer.dart';

extension FirebaseAuthUserX on User {
  Customer toCustomer() => Customer(id: uid, email: email ?? '');
}
