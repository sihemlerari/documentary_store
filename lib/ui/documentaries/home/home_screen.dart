import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../composition_root.dart';
import '../../theme/sizes.dart';
import 'cubit/documentaries_cubit.dart';
import 'widgets/documentary_list.dart';
import 'widgets/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const HomeDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: Sizes.s48),
          child: Column(
            children: [
              const HomeHeader(),
              gapH32,
              BlocProvider(
                create: (context) => getIt<DocumentariesCubit>()..loadDocumentaries(),
                child: const DocumentaryList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Discover',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        gapH8,
        Text(
          'Dive into a world of exploration',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
