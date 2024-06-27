import '../documentary_detail.dart';

abstract interface class DocumentaryDetailDataSource {
  Future<DocumentaryDetail?> documentaryById(String documentaryId);
}
