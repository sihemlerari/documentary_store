import 'package:flutter/material.dart';

class SuccessSnackBar extends SnackBar {
  SuccessSnackBar({
    super.key,
    required BuildContext context,
    required String message,
    super.duration = const Duration(seconds: 5),
  }) : super(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        );
}

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar({
    super.key,
    required BuildContext context,
    required String message,
    super.duration = const Duration(seconds: 5),
  }) : super(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
}
