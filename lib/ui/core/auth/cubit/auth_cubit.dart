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
  ) : super(const AuthState.unauthenticated());

  void checkAuthentication() async {
    final customer = await _getCurrentCustomer();
    if (customer != null) {
      emit(AuthState.authenticated(customer.id, customer.email));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  void signInWithGoogle() async {
    await _signInWithGoogle();
    checkAuthentication();
  }

  void signOut() async {
    await _signOut();
    emit(const AuthState.unauthenticated());
  }
}
