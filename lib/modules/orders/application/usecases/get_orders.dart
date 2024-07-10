import '../order_summary.dart';
import '../ports/order_summary_data_source.dart';

class GetOrders {
  final OrderSummaryDataSource _dataSource;

  GetOrders(this._dataSource);

  Future<List<OrderSummary>> call(String customerId) async {
    return _dataSource.ordersOf(customerId);
  }
}
