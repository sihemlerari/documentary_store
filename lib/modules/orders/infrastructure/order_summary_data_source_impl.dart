import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/infrastructure/firestore_operation_mixin.dart';
import '../application/order_summary.dart';
import '../application/ports/order_summary_data_source.dart';
import 'order_persisted.dart';

class OrderSummaryDataSourceImpl with FirestoreOperationMixin implements OrderSummaryDataSource {
  final FirebaseFirestore _firestore;

  OrderSummaryDataSourceImpl(this._firestore);

  @override
  Future<List<OrderSummary>> ordersOf(String customerId) async {
    return tryOperation(() async {
      final snapshot = await _firestore
          .collection('orders')
          .where('customerId', isEqualTo: customerId)
          .orderBy('purchaseDate', descending: true)
          .get();

      return List.unmodifiable(
        snapshot.docs.map(
          (doc) => _toViewModel(OrderPersisted.fromMap(doc.data(), doc.id)),
        ),
      );
    });
  }

  OrderSummary _toViewModel(OrderPersisted persisted) {
    final expirationDate = persisted.expirationDate;
    return OrderSummary(
      id: persisted.id,
      documentaryName: persisted.documentary.name,
      purchaseDate: persisted.purchaseDate,
      isExpired: expirationDate.isExpired(DateTime.now()),
    );
  }
}
