part of 'documentaries_cubit.dart';

sealed class DocumentariesState {}

final class DocumentariesLoading extends DocumentariesState {}

final class DocumentariesLoaded extends DocumentariesState {
  final List<DocumentarySummary> documentaries;

  DocumentariesLoaded(this.documentaries);
}

final class DocumentariesError extends DocumentariesState {
  final String message;

  DocumentariesError(this.message);
}
