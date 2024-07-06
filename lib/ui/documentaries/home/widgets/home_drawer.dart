import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/cubit/auth_cubit.dart';
import '../../../router.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return ListView(
            children: [
              const DrawerHeader(
                child: Placeholder(),
              ),
              if (state.isAuthenticated) ...[
                ListTile(
                  title: const Text('Purchased Documentaries'),
                  onTap: () {
                    context.goNamed(Routes.orders.name);
                  },
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).signOut();
                  },
                ),
              ] else ...[
                ListTile(
                  title: const Text('Login'),
                  onTap: () {
                    context.goNamed(Routes.login.name);
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
