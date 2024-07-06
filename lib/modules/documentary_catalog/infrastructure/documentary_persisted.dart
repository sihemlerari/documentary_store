class DocumentaryPersisted {
  final String id;
  final String name;
  final PurchaseOptionDetails purchaseOptionDetails;
  final double rating;
  final String category;
  final Duration duration;
  final String releaseYear;
  final String synopsis;
  final String mainImageUrl;

  const DocumentaryPersisted({
    required this.id,
    required this.name,
    required this.purchaseOptionDetails,
    required this.rating,
    required this.category,
    required this.duration,
    required this.releaseYear,
    required this.synopsis,
    required this.mainImageUrl,
  });

  factory DocumentaryPersisted.fromMap(Map<String, dynamic> map, String documentId) {
    return DocumentaryPersisted(
      id: documentId,
      name: map['name'] as String,
      purchaseOptionDetails: PurchaseOptionDetails.fromMap(map['purchaseOption']),
      rating: (map['rating'] as num).toDouble(),
      category: map['category'] as String,
      duration: Duration(minutes: map['duration'] as int),
      releaseYear: map['releaseYear'] as String,
      synopsis: map['synopsis'] as String,
      mainImageUrl: map['mainImageUrl'] as String,
    );
  }
}

class PurchaseOptionDetails {
  final PurchaseOptionPersisted purchaseOption;
  final double price;

  const PurchaseOptionDetails({
    required this.purchaseOption,
    required this.price,
  });

  factory PurchaseOptionDetails.fromMap(Map<String, dynamic> map) {
    if (map['rent'] != null) {
      return PurchaseOptionDetails(
        purchaseOption: PurchaseOptionPersisted.rent,
        price: (map['rent']['price'] as num).toDouble(),
      );
    }
    return PurchaseOptionDetails(
      purchaseOption: PurchaseOptionPersisted.buy,
      price: (map['buy']['price'] as num).toDouble(),
    );
  }
}

enum PurchaseOptionPersisted {
  rent,
  buy,
}
