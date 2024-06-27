import '../documentary_summary.dart';
import '../ports/documentary_summary_data_source.dart';

class GetDocumentaries {
  final DocumentarySummaryDataSource _dataSource;

  GetDocumentaries(this._dataSource);

  Future<List<DocumentarySummary>> call() async {
    return _dataSource.documentaries();
  }
}
