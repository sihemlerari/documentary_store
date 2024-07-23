import '../../../../modules/documentary_catalog/application/documentary_summary.dart';
import '../../../../modules/documentary_catalog/application/usecases/get_documentary_summary.dart';
import '../../../core/base_cubit.dart';

part 'order_summary_state.dart';

class OrderSummaryCubit extends BaseCubit<OrderSummaryState> {
  final GetDocumentarySummary _getDocumentarySummary;

  OrderSummaryCubit(this._getDocumentarySummary) : super(OrderSummaryLoading());

  void loadOrderSummary(String documentaryId) async {
    emit(OrderSummaryLoading());

    execute(
      () => _getDocumentarySummary(documentaryId),
      onSuccess: (response) {
        emit(OrderSummaryLoaded(response));
      },
      onFailure: (error) {
        emit(OrderSummaryError(error));
      },
    );
  }
}
