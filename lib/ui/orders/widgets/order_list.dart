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
      itemBuilder: (context, index) {
        final order = orders[index];
        return ListTile(
          title: Text('Order ID: ${order.id}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.documentaryName.toUpperCase()),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.s4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(Sizes.s8),
                  ),
                  child: order.isExpired ? const Text('Expired') : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
          isThreeLine: true,
          trailing: FormattedDate(dateTime: order.purchaseDate),
        );
      },
    );
  }
}
