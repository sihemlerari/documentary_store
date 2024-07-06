part of 'documentary_detail_cubit.dart';

sealed class DocumentaryDetailState {}

final class DocumentaryDetailLoading extends DocumentaryDetailState {}

final class DocumentaryDetailLoaded extends DocumentaryDetailState {
  final DocumentaryDetail documentary;

  DocumentaryDetailLoaded(this.documentary);
}

final class DocumentaryDetailError extends DocumentaryDetailState {
  final String message;

  DocumentaryDetailError(this.message);
}
