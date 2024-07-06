import 'package:flutter/material.dart';

import '../../../theme/sizes.dart';

class DocumentaryDuration extends StatelessWidget {
  final Duration duration;

  const DocumentaryDuration({
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final durationInMinutes = '${duration.inMinutes}min';

    final minutesRemaining = duration.inMinutes.remainder(60);
    final durationInHours = minutesRemaining > 0
        ? '${duration.inHours}h ${minutesRemaining}min'
        : '${duration.inHours}h';

    return Row(
      children: [
        const Icon(Icons.access_time),
        gapW4,
        Text(
          duration.inMinutes > 60 ? durationInHours : durationInMinutes,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
