import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../modules/documentary_catalog/application/documentary_detail.dart';
import '../../../theme/sizes.dart';
import '../../widgets/documentary_rating.dart';

class DocumentaryHeader extends StatelessWidget {
  final DocumentaryDetail documentary;

  const DocumentaryHeader({
    required this.documentary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.s16),
      color: const Color(0xFF9b3537),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: const Divider(
                  color: Colors.white,
                ).animate().scale(curve: Curves.easeOut, duration: 500.ms),
              ),
              Padding(
                padding: const EdgeInsets.all(Sizes.s16),
                child: Text(
                  documentary.category,
                  style: Theme.of(context).textTheme.titleMedium,
                ).animate().moveY(duration: 300.ms),
              ),
              Expanded(
                child: const Divider(
                  color: Colors.white,
                ).animate().scale(curve: Curves.easeOut, duration: 500.ms),
              ),
            ],
          ),
          Text(
            documentary.name.toUpperCase(),
            style: Theme.of(context).textTheme.headlineMedium,
          ).animate().moveY(duration: 300.ms),
          gapH32,
          DocumentaryRating(rating: documentary.rating).animate().moveY(duration: 300.ms),
        ],
      ),
    );
  }
}
