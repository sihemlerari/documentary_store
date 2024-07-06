import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/infrastructure/firestore_operation_mixin.dart';
import '../application/documentary_detail.dart';
import '../application/ports/documentary_detail_data_source.dart';
import '../application/purchase_option.dart';
import 'documentary_persisted.dart';

class DocumentaryDetailDataSourceImpl
    with FirestoreOperationMixin
    implements DocumentaryDetailDataSource {
  final FirebaseFirestore _firestore;

  DocumentaryDetailDataSourceImpl(this._firestore);

  @override
  Future<DocumentaryDetail?> documentaryById(String documentaryId) async {
    return tryOperation(() async {
      final doc = await _firestore.collection('documentaries').doc(documentaryId).get();
      final map = doc.data();
      if (map == null) return null;

      return _toViewModel(DocumentaryPersisted.fromMap(map, doc.id));
    });
  }

  DocumentaryDetail _toViewModel(DocumentaryPersisted persisted) {
    final purchaseOption = switch (persisted.purchaseOptionDetails.purchaseOption) {
      PurchaseOptionPersisted.rent => PurchaseOption.rent,
      PurchaseOptionPersisted.buy => PurchaseOption.buy,
    };

    return DocumentaryDetail(
        id: persisted.id,
        name: persisted.name,
        purchaseOption: purchaseOption,
        price: persisted.purchaseOptionDetails.price,
        rating: persisted.rating,
        category: persisted.category,
        duration: persisted.duration,
        releaseYear: persisted.releaseYear,
        synopsis: persisted.synopsis,
        mainImageUrl: persisted.mainImageUrl);
  }
}
