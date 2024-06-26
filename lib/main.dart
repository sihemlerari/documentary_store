import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'composition_root.dart';
import 'firebase_options.dart';
import 'ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependencies();

  runApp(const App());
}
