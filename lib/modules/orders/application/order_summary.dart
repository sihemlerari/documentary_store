class OrderSummary {
  final String id;
  final String documentaryName;
  final DateTime purchaseDate;
  final bool isExpired;

  const OrderSummary({
    required this.id,
    required this.documentaryName,
    required this.purchaseDate,
    required this.isExpired,
  });
}
