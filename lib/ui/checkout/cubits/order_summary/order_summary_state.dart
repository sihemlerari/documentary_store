part of 'order_summary_cubit.dart';

sealed class OrderSummaryState {}

final class OrderSummaryLoading extends OrderSummaryState {}

final class OrderSummaryLoaded extends OrderSummaryState {
  final DocumentarySummary documentary;

  OrderSummaryLoaded(this.documentary);
}

final class OrderSummaryError extends OrderSummaryState {
  final String message;

  OrderSummaryError(this.message);
}
