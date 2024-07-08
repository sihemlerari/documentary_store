import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'cubit/auth_cubit.dart';
import 'guard.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouter.of(context).routeInformationProvider.value.uri.path;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => switch (state) {
        AuthInitial() => const Center(child: CircularProgressIndicator()),
        Authenticated() || Unauthenticated() => Guard(
            canActivate: state.isAuthenticated,
            child: child,
            onRedirect: (context) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pushReplacement('/login?goto=$currentPath');
              });
            })
      },
    );
  }
}
