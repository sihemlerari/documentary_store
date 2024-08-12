import 'package:cloud_firestore/cloud_firestore.dart';

import 'expiration_date.dart';
import 'timestamp_extension.dart';

class OrderPersisted {
  final String id;
  final String customerId;
  final PurchasedDocumentary documentary;
  final double price;
  final DateTime purchaseDate;
  final ExpirationDate expirationDate;

  const OrderPersisted({
    required this.id,
    required this.customerId,
    required this.documentary,
    required this.price,
    required this.purchaseDate,
    required this.expirationDate,
  });

  factory OrderPersisted.fromMap(Map<String, dynamic> map, String documentId) {
    final purchaseTimestamp = map['purchaseDate'] as Timestamp;
    final expirationTimestamp = map['expirationDate'] as Timestamp?;

    return OrderPersisted(
      id: documentId,
      customerId: map['customerId'] as String,
      documentary: PurchasedDocumentary.fromMap(map['documentary']),
      price: (map['price'] as num).toDouble(),
      purchaseDate: purchaseTimestamp.toDateTime(),
      expirationDate: expirationTimestamp == null
          ? const ExpirationDate.infinite()
          : ExpirationDate(expirationTimestamp.toDateTime()),
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
