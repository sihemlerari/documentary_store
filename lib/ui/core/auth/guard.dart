import 'package:flutter/material.dart';

class Guard extends StatelessWidget {
  final bool canActivate;
  final Function(BuildContext context) onRedirect;
  final Widget child;

  const Guard({
    super.key,
    required this.canActivate,
    required this.onRedirect,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (canActivate) return child;

    onRedirect(context);
    return const SizedBox();
  }
}
