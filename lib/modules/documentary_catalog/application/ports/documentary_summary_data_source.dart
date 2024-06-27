import '../documentary_summary.dart';

abstract interface class DocumentarySummaryDataSource {
  Future<List<DocumentarySummary>> documentaries();
}
