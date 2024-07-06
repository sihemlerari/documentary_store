import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../modules/documentary_catalog/application/documentary_summary.dart';
import '../../../../modules/documentary_catalog/application/purchase_option.dart';
import '../../../core/widgets/formatted_price.dart';
import '../../../theme/sizes.dart';
import '../../widgets/documentary_rating.dart';

class DocumentaryCard extends StatelessWidget {
  final DocumentarySummary documentary;
  final VoidCallback? onTap;

  const DocumentaryCard({
    required this.documentary,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(Sizes.s32),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Sizes.s20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DocumentaryCardImage(documentary: documentary),
              gapH24,
              Text(
                documentary.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              gapH24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DocumentaryRating(rating: documentary.rating),
                  Row(
                    children: [
                      Text(
                        documentary.purchaseOption == PurchaseOption.rent ? 'Rent' : 'Buy',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      gapW8,
                      FormattedPrice(
                        price: documentary.price,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Icon(Icons.arrow_right_alt_rounded)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentaryCardImage extends StatelessWidget {
  const DocumentaryCardImage({
    super.key,
    required this.documentary,
  });

  final DocumentarySummary documentary;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.s20),
      child: CachedNetworkImage(
        imageUrl: documentary.mainImageUrl,
        fit: BoxFit.cover,
        height: 380,
      ),
    );
  }
}
