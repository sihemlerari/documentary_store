import 'package:documentary_store/modules/orders/application/order_summary.dart';
import 'package:documentary_store/modules/orders/application/ports/order_summary_data_source.dart';
import 'package:documentary_store/modules/orders/application/usecases/get_orders.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late GetOrders getOrders;
  late OrderSummaryDataSourceStub dataSource;

  const aliceId = 'aliceId';
  final List<OrderSummary> orders = [
    OrderSummary(id: '1', documentaryName: 'Citizenfour', purchaseDate: DateTime(2024, 1, 1)),
    OrderSummary(id: '2', documentaryName: 'Senna', purchaseDate: DateTime(2024, 1, 2)),
    OrderSummary(id: '3', documentaryName: 'Inside Job', purchaseDate: DateTime(2024, 1, 3)),
  ];

  setUp(() {
    dataSource = OrderSummaryDataSourceStub();
    getOrders = GetOrders(dataSource);
  });

  test('should return an empty list when no orders are available for the specified customer',
      () async {
    final result = await getOrders(aliceId);

    expect(result, isEmpty);
  });

  test('should return a list of orders for the specified customer', () async {
    dataSource.loadOrdersFor(aliceId, orders);

    final result = await getOrders(aliceId);

    expect(result, hasLength(3));
    expect(result, orders);
  });
}

class OrderSummaryDataSourceStub implements OrderSummaryDataSource {
  final Map<String, List<OrderSummary>> _orders = {};

  void loadOrdersFor(String customerId, List<OrderSummary> orders) {
    _orders[customerId] = orders;
  }

  @override
  Future<List<OrderSummary>> ordersOf(String customerId) async =>
      Future.value(_orders[customerId] ?? []);
}
