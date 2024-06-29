import 'package:bloc/bloc.dart';

import '../../modules/shared/domain/domain_exception.dart';
import '../../modules/shared/infrastructure/infrastructure_exception.dart';

abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);

  Future<void> execute<T>(
    Future<T> Function() action, {
    required void Function(T response) onSuccess,
    required void Function(String message) onFailure,
  }) async {
    try {
      final response = await action();

      onSuccess.call(response);
    } on DomainException catch (error) {
      onFailure.call(error.message);
    } on InfrastructureException catch (error) {
      onFailure.call(error.message);
    }
  }
}
