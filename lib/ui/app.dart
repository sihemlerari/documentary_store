import 'package:flutter/material.dart';

import 'router.dart';
import 'theme/dark_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Documentary Store',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      routerConfig: router,
    );
  }
}
