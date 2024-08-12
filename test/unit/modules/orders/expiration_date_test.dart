import 'package:documentary_store/modules/orders/infrastructure/expiration_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.now();

  test('should return true if the date is expired', () {
    expect(ExpirationDate(DateTime(2024, 1, 1)).isExpired(now), isTrue);
  });

  test('should return false if the date is infinite', () {
    expect(const ExpirationDate.infinite().isExpired(now), isFalse);
  });

  test('two expiration dates with the same value should be equal', () {
    final expirationDate1 = ExpirationDate(DateTime(2024, 1, 1));
    final expirationDate2 = ExpirationDate(DateTime(2024, 1, 1));

    expect(expirationDate1, expirationDate2);
  });

  test('two different expiration dates should not be equal', () {
    final expirationDate1 = ExpirationDate(DateTime(2024, 1, 1));
    final expirationDate2 = ExpirationDate(DateTime(2024, 1, 2));

    expect(expirationDate1, isNot(expirationDate2));
  });
}
