import 'package:flutter/material.dart';

import '../../../../modules/documentary_catalog/application/documentary_detail.dart';
import '../../../../modules/documentary_catalog/application/purchase_option.dart';
import '../../../core/widgets/formatted_price.dart';
import '../../../theme/sizes.dart';

class PurchaseButton extends StatelessWidget {
  final DocumentaryDetail documentary;
  final VoidCallback? onTap;

  const PurchaseButton({
    required this.documentary,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onTap,
      label: Row(
        children: [
          FormattedPrice(price: documentary.price),
          gapW24,
          Text(
            (documentary.purchaseOption == PurchaseOption.rent ? 'Rent now' : 'Buy now')
                .toUpperCase(),
          ),
          const Icon(Icons.arrow_right_alt_rounded)
        ],
      ),
    );
  }
}
