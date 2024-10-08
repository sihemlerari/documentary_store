import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widgets/formatted_price.dart';
import '../../theme/sizes.dart';
import '../cubits/order_summary/order_summary_cubit.dart';
import 'checkout_section.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return CheckoutSection(
      title: 'Order Summary',
      child: BlocBuilder<OrderSummaryCubit, OrderSummaryState>(
        builder: (context, state) {
          return switch (state) {
            OrderSummaryLoading() => const Center(child: CircularProgressIndicator()),
            OrderSummaryError() => Center(child: Text(state.message)),
            OrderSummaryLoaded() => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Sizes.s16),
                        child: CachedNetworkImage(
                          imageUrl: state.documentary.mainImageUrl,
                          width: 100,
                        ),
                      ),
                      Text(
                        state.documentary.name.toUpperCase(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  gapH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      FormattedPrice(
                          price: state.documentary.price,
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}
