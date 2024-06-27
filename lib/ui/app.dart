import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../composition_root.dart';
import 'core/auth/cubit/auth_cubit.dart';
import 'router.dart';
import 'theme/dark_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..checkAuthentication(),
      child: MaterialApp.router(
        title: 'Documentary Store',
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        routerConfig: router,
      ),
    );
  }
}
