import 'package:documentary_store/modules/documentary_catalog/application/documentary_summary.dart';
import 'package:documentary_store/modules/documentary_catalog/application/purchase_option.dart';
import 'package:documentary_store/modules/documentary_catalog/application/usecases/get_documentary_summary.dart';
import 'package:documentary_store/modules/shared/domain/domain_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import 'doubles/documentary_summary_data_source_stub.dart';

void main() {
  late GetDocumentarySummary getDocumentarySummary;
  late DocumentarySummaryDataSourceStub dataSource;

  const String theSocialDilemmaId = 'the_social_dilemma_id';
  const DocumentarySummary theSocialDilemma = DocumentarySummary(
    id: theSocialDilemmaId,
    name: 'The Social Dilemma',
    purchaseOption: PurchaseOption.buy,
    price: 14.99,
    rating: 3.5,
    mainImageUrl: 'https://www.example.com/the_social_dilemma.jpg',
  );

  setUp(() {
    dataSource = DocumentarySummaryDataSourceStub();
    getDocumentarySummary = GetDocumentarySummary(dataSource);
  });

  test('should return documentary summary for a valid ID', () async {
    dataSource.loadDocumentaries([theSocialDilemma]);

    final result = await getDocumentarySummary(theSocialDilemmaId);

    expect(result, theSocialDilemma);
  });

  test('should fail if documentary is not found', () async {
    expect(() => getDocumentarySummary(theSocialDilemmaId),
        throwsA(const DocumentaryNotFound(theSocialDilemmaId)));
  });
}
