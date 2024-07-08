import 'package:documentary_store/modules/documentary_catalog/application/documentary_summary.dart';
import 'package:documentary_store/modules/documentary_catalog/application/purchase_option.dart';
import 'package:documentary_store/modules/documentary_catalog/application/usecases/get_documentaries.dart';
import 'package:flutter_test/flutter_test.dart';

import 'doubles/documentary_summary_data_source_stub.dart';

void main() {
  late GetDocumentaries getDocumentaries;
  late DocumentarySummaryDataSourceStub dataSource;

  const List<DocumentarySummary> documentaries = [
    DocumentarySummary(
      id: 'our_planet_id',
      name: 'Our Planet',
      purchaseOption: PurchaseOption.rent,
      price: 4.99,
      rating: 4.5,
      mainImageUrl: 'https://www.example.com/our-planet.jpg',
    ),
    DocumentarySummary(
      id: 'citizenfour_id',
      name: 'Citizenfour',
      purchaseOption: PurchaseOption.buy,
      price: 14.99,
      rating: 4.3,
      mainImageUrl: 'https://www.example.com/citizenfour.jpg',
    ),
  ];

  setUp(() {
    dataSource = DocumentarySummaryDataSourceStub();
    getDocumentaries = GetDocumentaries(dataSource);
  });

  test('should return an empty list when no documentaries are available', () async {
    final result = await getDocumentaries();

    expect(result, isEmpty);
  });

  test('should return a list of documentaries', () async {
    dataSource.loadDocumentaries(documentaries);

    final result = await getDocumentaries();

    expect(result, hasLength(2));
    expect(result, documentaries);
  });
}
