import 'package:cloud_firestore/cloud_firestore.dart';

import 'infrastructure_exception.dart';

mixin FirestoreOperationMixin {
  Future<T> tryOperation<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        throw const NetworkException();
      }
      if (e.code == 'deadline-exceeded') {
        throw const TimeoutException();
      }
      if (e.code == 'permission-denied') {
        throw const PermissionDeniedException();
      }
      rethrow;
    }
  }
}
