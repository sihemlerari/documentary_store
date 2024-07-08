import '../documentary_summary.dart';

abstract interface class DocumentarySummaryDataSource {
  Future<DocumentarySummary?> documentaryById(String documentaryId);
  Future<List<DocumentarySummary>> documentaries();
}
