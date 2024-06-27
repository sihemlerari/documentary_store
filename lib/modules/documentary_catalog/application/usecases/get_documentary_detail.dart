import '../../../shared/domain/domain_exception.dart';
import '../documentary_detail.dart';
import '../ports/documentary_detail_data_source.dart';

class GetDocumentaryDetail {
  final DocumentaryDetailDataSource _dataSource;

  GetDocumentaryDetail(this._dataSource);

  Future<DocumentaryDetail> call(String documentaryId) async {
    final documentary = await _dataSource.documentaryById(documentaryId);
    if (documentary == null) {
      throw DocumentaryNotFound(documentaryId);
    }
    return documentary;
  }
}
