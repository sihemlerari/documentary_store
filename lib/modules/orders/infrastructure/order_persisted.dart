import 'package:cloud_firestore/cloud_firestore.dart';

class OrderPersisted {
  final String id;
  final String customerId;
  final PurchasedDocumentary documentary;
  final double price;
  final DateTime purchaseDate;
  final DateTime? expirationDate;

  const OrderPersisted({
    required this.id,
    required this.customerId,
    required this.documentary,
    required this.price,
    required this.purchaseDate,
    required this.expirationDate,
  });

  factory OrderPersisted.fromMap(Map<String, dynamic> map, String documentId) {
    final expirationDate = map['expirationDate'] as Timestamp?;
    return OrderPersisted(
      id: documentId,
      customerId: map['customerId'] as String,
      documentary: PurchasedDocumentary.fromMap(map['documentary']),
      price: (map['price'] as num).toDouble(),
      purchaseDate: DateTime.fromMillisecondsSinceEpoch(
          (map['purchaseDate'] as Timestamp).millisecondsSinceEpoch),
      expirationDate: expirationDate == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch((expirationDate).millisecondsSinceEpoch),
    );
  }
}

class PurchasedDocumentary {
  final String id;
  final String name;

  const PurchasedDocumentary({
    required this.id,
    required this.name,
  });

  factory PurchasedDocumentary.fromMap(Map<String, dynamic> map) {
    return PurchasedDocumentary(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
