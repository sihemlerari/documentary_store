import 'package:flutter/material.dart';

import '../../../modules/orders/application/order_summary.dart';
import '../../core/widgets/formatted_date.dart';
import '../../theme/sizes.dart';

class OrderList extends StatelessWidget {
  final List<OrderSummary> orders;

  const OrderList({
    required this.orders,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) => OrderCard(order: orders[index]),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderSummary order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: Sizes.s8),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.s12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            gapH4,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FormattedDate(dateTime: order.purchaseDate),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.s8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(Sizes.s8),
                  ),
                  child: order.isExpired ? const Text('expired') : const SizedBox.shrink(),
                ),
              ],
            ),
            gapH16,
            Text(
              order.documentaryName.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
