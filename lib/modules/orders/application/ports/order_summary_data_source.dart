import '../order_summary.dart';

abstract interface class OrderSummaryDataSource {
  Future<List<OrderSummary>> ordersOf(String customerId);
}
