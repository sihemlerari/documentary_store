import '../../../shared/domain/domain_exception.dart';
import '../documentary_summary.dart';
import '../ports/documentary_summary_data_source.dart';

class GetDocumentarySummary {
  final DocumentarySummaryDataSource _dataSource;

  GetDocumentarySummary(this._dataSource);

  Future<DocumentarySummary> call(String documentaryId) async {
    final documentary = await _dataSource.documentaryById(documentaryId);
    if (documentary == null) {
      throw DocumentaryNotFound(documentaryId);
    }
    return documentary;
  }
}
