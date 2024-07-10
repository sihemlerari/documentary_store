import '../../../modules/orders/application/order_summary.dart';
import '../../../modules/orders/application/usecases/get_orders.dart';
import '../../core/base_cubit.dart';

part 'orders_state.dart';

class OrdersCubit extends BaseCubit<OrdersState> {
  final GetOrders _getOrders;
  OrdersCubit(this._getOrders) : super(OrdersLoading());

  Future<void> loadOrders(String customerId) async {
    emit(OrdersLoading());

    execute(
      () => _getOrders(customerId),
      onSuccess: (orders) {
        emit(OrdersLoaded(orders));
      },
      onFailure: (message) {
        emit(OrdersError(message));
      },
    );
  }
}
