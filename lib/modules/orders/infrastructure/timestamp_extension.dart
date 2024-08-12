import 'package:cloud_firestore/cloud_firestore.dart';

extension TimestampExtension on Timestamp {
  DateTime toDateTime() => DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}
