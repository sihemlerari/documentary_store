import 'package:collection/collection.dart';
import 'package:documentary_store/modules/documentary_catalog/application/documentary_detail.dart';
import 'package:documentary_store/modules/documentary_catalog/application/ports/documentary_detail_data_source.dart';
import 'package:documentary_store/modules/documentary_catalog/application/purchase_option.dart';
import 'package:documentary_store/modules/documentary_catalog/application/usecases/get_documentary_detail.dart';
import 'package:documentary_store/modules/shared/domain/domain_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GetDocumentaryDetail getDocumentaryDetail;
  late DocumentaryDetailDataSourceStub dataSource;

  const String ourPlanetId = 'our_planet_id';
  const DocumentaryDetail ourPlanet = DocumentaryDetail(
    id: ourPlanetId,
    name: 'Our Planet',
    purchaseOption: PurchaseOption.rent,
    price: 4.99,
    rating: 4.5,
    category: 'Nature',
    duration: Duration(minutes: 50),
    releaseYear: '2019',
    synopsis: 'A documentary series on life on Earth.',
    mainImageUrl: 'https://www.example.com/our-planet.jpg',
  );

  setUp(() {
    dataSource = DocumentaryDetailDataSourceStub();
    getDocumentaryDetail = GetDocumentaryDetail(dataSource);
  });

  test('should return documentary detail for a valid ID', () async {
    dataSource.loadDocumentaries([ourPlanet]);

    final result = await getDocumentaryDetail(ourPlanetId);

    expect(result, ourPlanet);
  });

  test('should fail if documentary is not found', () async {
    expect(
        () => getDocumentaryDetail(ourPlanetId), throwsA(const DocumentaryNotFound(ourPlanetId)));
  });
}

class DocumentaryDetailDataSourceStub implements DocumentaryDetailDataSource {
  List<DocumentaryDetail> _documentaries = [];

  void loadDocumentaries(List<DocumentaryDetail> documentaries) {
    _documentaries = documentaries;
  }

  @override
  Future<DocumentaryDetail?> documentaryById(String documentaryId) async {
    return _documentaries.firstWhereOrNull((documentary) => documentary.id == documentaryId);
  }
}
