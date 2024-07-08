import 'package:bloc/bloc.dart';

import '../../../../modules/auth/application/usecases/get_current_customer.dart';
import '../../../../modules/auth/application/usecases/sign_in_with_google.dart';
import '../../../../modules/auth/application/usecases/sign_out.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentCustomer _getCurrentCustomer;
  final SignInWithGoogle _signInWithGoogle;
  final SignOut _signOut;

  AuthCubit(
    this._getCurrentCustomer,
    this._signInWithGoogle,
    this._signOut,
  ) : super(const AuthInitial());

  Future<void> checkAuthentication() async {
    final customer = await _getCurrentCustomer();
    if (customer != null) {
      emit(Authenticated(User(id: customer.id, email: customer.email)));
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> signInWithGoogle() async {
    await _signInWithGoogle();
    checkAuthentication();
  }

  Future<void> signOut() async {
    await _signOut();
    emit(const Unauthenticated());
  }
}
