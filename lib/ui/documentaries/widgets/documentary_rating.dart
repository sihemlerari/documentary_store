import 'package:flutter/material.dart';

import '../../theme/sizes.dart';

class DocumentaryRating extends StatelessWidget {
  final double rating;

  const DocumentaryRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        gapW4,
        Text(
          rating.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
