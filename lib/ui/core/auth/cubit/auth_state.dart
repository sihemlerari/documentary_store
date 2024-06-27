part of 'auth_cubit.dart';

class AuthState {
  final User user;

  const AuthState(this.user);

  AuthState.authenticated(String id, String email) : this(AuthUser(id: id, email: email));

  const AuthState.unauthenticated() : this(const AnonymousUser());

  bool get isAuthenticated => user is AuthUser;

  @override
  bool operator ==(covariant AuthState other) {
    if (identical(this, other)) return true;

    return other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

abstract class User {
  const User();
}

class AuthUser extends User {
  final String id;
  final String email;

  const AuthUser({
    required this.id,
    required this.email,
  });
}

class AnonymousUser extends User {
  const AnonymousUser();
}
