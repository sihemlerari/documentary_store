import '../../../../modules/documentary_catalog/application/documentary_detail.dart';
import '../../../../modules/documentary_catalog/application/usecases/get_documentary_detail.dart';
import '../../../core/base_cubit.dart';

part 'documentary_detail_state.dart';

class DocumentaryDetailCubit extends BaseCubit<DocumentaryDetailState> {
  final GetDocumentaryDetail _getDocumentaryDetail;

  DocumentaryDetailCubit(this._getDocumentaryDetail) : super(DocumentaryDetailLoading());

  void loadDocumentaryById(String documentaryId) async {
    emit(DocumentaryDetailLoading());

    execute(
      () => _getDocumentaryDetail(documentaryId),
      onSuccess: (response) {
        emit(DocumentaryDetailLoaded(response));
      },
      onFailure: (error) {
        emit(DocumentaryDetailError(error));
      },
    );
  }
}
