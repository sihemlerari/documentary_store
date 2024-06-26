import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/auth/cubit/auth_cubit.dart';
import '../theme/sizes.dart';

class LoginScreen extends StatelessWidget {
  final String? goto;

  const LoginScreen({
    super.key,
    this.goto,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isAuthenticated) {
          context.replace(goto ?? '/');
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Sizes.s64),
                  child: Image.asset(
                    'assets/logo.png',
                    height: 120,
                  ),
                ).animate().moveY(duration: 500.ms),
                Text(
                  'Sign in to Documentary Store',
                  style: Theme.of(context).textTheme.bodyLarge,
                ).animate().moveY(duration: 500.ms),
                gapH32,
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<AuthCubit>().signInWithGoogle();
                  },
                  icon: Image.asset(
                    'assets/google_logo.png',
                    height: 24,
                  ),
                  label: const Text('Sign in with Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
