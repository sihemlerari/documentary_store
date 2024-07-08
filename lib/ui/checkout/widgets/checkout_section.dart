import 'package:flutter/material.dart';

import '../../theme/sizes.dart';

class CheckoutSection extends StatelessWidget {
  final String title;
  final Widget child;

  const CheckoutSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            gapH24,
            child
          ],
        ),
      ),
    );
  }
}
