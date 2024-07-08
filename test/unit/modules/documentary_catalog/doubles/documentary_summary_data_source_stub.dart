import 'package:collection/collection.dart';
import 'package:documentary_store/modules/documentary_catalog/application/documentary_summary.dart';
import 'package:documentary_store/modules/documentary_catalog/application/ports/documentary_summary_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

class DocumentarySummaryDataSourceStub implements DocumentarySummaryDataSource {
  List<DocumentarySummary> _documentaries = [];

  void loadDocumentaries(List<DocumentarySummary> documentaries) {
    _documentaries = documentaries;
  }

  @override
  Future<DocumentarySummary?> documentaryById(String documentaryId) async =>
      _documentaries.firstWhereOrNull((documentary) => documentary.id == documentaryId);

  @override
  Future<List<DocumentarySummary>> documentaries() async => _documentaries;
}
