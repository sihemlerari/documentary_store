import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/infrastructure/firestore_operation_mixin.dart';
import '../application/documentary_summary.dart';
import '../application/ports/documentary_summary_data_source.dart';
import '../application/purchase_option.dart';
import 'documentary_persisted.dart';

class DocumentarySummaryDataSourceImpl
    with FirestoreOperationMixin
    implements DocumentarySummaryDataSource {
  final FirebaseFirestore _firestore;

  DocumentarySummaryDataSourceImpl(this._firestore);

  @override
  Future<List<DocumentarySummary>> documentaries() async {
    return tryOperation(() async {
      final snapshot = await _firestore.collection('documentaries').get();

      return List.unmodifiable(
        snapshot.docs.map(
          (doc) => _toViewModel(DocumentaryPersisted.fromMap(doc.data(), doc.id)),
        ),
      );
    });
  }

  @override
  Future<DocumentarySummary?> documentaryById(String documentaryId) {
    return tryOperation(() async {
      final doc = await _firestore.collection('documentaries').doc(documentaryId).get();
      final map = doc.data();
      if (map == null) return null;

      return _toViewModel(DocumentaryPersisted.fromMap(map, doc.id));
    });
  }

  DocumentarySummary _toViewModel(DocumentaryPersisted persisted) {
    final purchaseOption = switch (persisted.purchaseOptionDetails.purchaseOption) {
      PurchaseOptionPersisted.rent => PurchaseOption.rent,
      PurchaseOptionPersisted.buy => PurchaseOption.buy,
    };

    return DocumentarySummary(
        id: persisted.id,
        name: persisted.name,
        purchaseOption: purchaseOption,
        price: persisted.purchaseOptionDetails.price,
        rating: persisted.rating,
        mainImageUrl: persisted.mainImageUrl);
  }
}
