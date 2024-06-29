import '../../../../modules/documentary_catalog/application/documentary_summary.dart';
import '../../../../modules/documentary_catalog/application/usecases/get_documentaries.dart';
import '../../../core/base_cubit.dart';

part 'documentaries_state.dart';

class DocumentariesCubit extends BaseCubit<DocumentariesState> {
  final GetDocumentaries _getDocumentaries;

  DocumentariesCubit(this._getDocumentaries) : super(DocumentariesLoading());

  void loadDocumentaries() async {
    emit(DocumentariesLoading());

    execute(
      () => _getDocumentaries(),
      onSuccess: (documentaries) {
        emit(DocumentariesLoaded(documentaries));
      },
      onFailure: (error) {
        emit(DocumentariesError(error));
      },
    );
  }
}
