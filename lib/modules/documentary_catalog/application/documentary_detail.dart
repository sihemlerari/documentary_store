import 'purchase_option.dart';

class DocumentaryDetail {
  final String id;
  final String name;
  final PurchaseOption purchaseOption;
  final double price;
  final double rating;
  final String category;
  final String releaseYear;
  final Duration duration;
  final String synopsis;
  final String mainImageUrl;

  const DocumentaryDetail({
    required this.id,
    required this.name,
    required this.purchaseOption,
    required this.price,
    required this.rating,
    required this.category,
    required this.duration,
    required this.releaseYear,
    required this.synopsis,
    required this.mainImageUrl,
  });

  @override
  bool operator ==(covariant DocumentaryDetail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.purchaseOption == purchaseOption &&
        other.price == price &&
        other.rating == rating &&
        other.category == category &&
        other.releaseYear == releaseYear &&
        other.duration == duration &&
        other.synopsis == synopsis &&
        other.mainImageUrl == mainImageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        purchaseOption.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        category.hashCode ^
        releaseYear.hashCode ^
        duration.hashCode ^
        synopsis.hashCode ^
        mainImageUrl.hashCode;
  }
}
