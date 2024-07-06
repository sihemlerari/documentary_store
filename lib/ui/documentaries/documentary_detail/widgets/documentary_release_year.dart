import 'package:flutter/material.dart';

import '../../../theme/sizes.dart';

class DocumentaryReleaseYear extends StatelessWidget {
  final String releaseYear;

  const DocumentaryReleaseYear({
    super.key,
    required this.releaseYear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.date_range),
        gapW4,
        Text(
          releaseYear,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
