import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/auth/cubit/auth_cubit.dart';
import '../../theme/sizes.dart';
import 'checkout_section.dart';

class DeliveryInformation extends StatelessWidget {
  const DeliveryInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return CheckoutSection(
      title: 'Delivery Information',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This documentary will be sent to',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH8,
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => switch (state) {
              Authenticated() => Text(
                  state.user.email,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              _ => const SizedBox.shrink()
            },
          ),
          gapH20,
          Text(
            'You will receive an email with a link to watch the documentary. If you have rented the documentary, you will have 48 hours to watch it.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
