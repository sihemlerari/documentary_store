part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();

  bool get isAuthenticated;
}

final class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  bool get isAuthenticated => false;
}

final class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  bool get isAuthenticated => true;
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();

  @override
  bool get isAuthenticated => false;
}

class User {
  final String id;
  final String email;

  const User({
    required this.id,
    required this.email,
  });

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
