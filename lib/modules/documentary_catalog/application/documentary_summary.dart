import 'purchase_option.dart';

class DocumentarySummary {
  final String id;
  final String name;
  final PurchaseOption purchaseOption;
  final double price;
  final double rating;
  final String mainImageUrl;

  const DocumentarySummary({
    required this.id,
    required this.name,
    required this.purchaseOption,
    required this.price,
    required this.rating,
    required this.mainImageUrl,
  });
}
