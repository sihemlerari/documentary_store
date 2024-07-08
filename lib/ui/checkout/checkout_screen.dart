import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/sizes.dart';
import 'widgets/delivery_information.dart';
import 'widgets/order_summary/order_summary.dart';

class CheckoutScreen extends StatelessWidget {
  final String documentaryId;

  const CheckoutScreen({
    super.key,
    required this.documentaryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.s16),
            child: Column(
              children: [
                OrderSummary(documentaryId: documentaryId).animate().moveY(duration: 500.ms),
                gapH16,
                const DeliveryInformation().animate().moveY(duration: 500.ms),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Continue to Payment'),
        ));
  }
}
