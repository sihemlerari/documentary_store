import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../modules/documentary_catalog/application/documentary_summary.dart';
import '../../../router.dart';
import '../cubit/documentaries_cubit.dart';
import 'documentary_card.dart';

class DocumentaryList extends StatelessWidget {
  const DocumentaryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentariesCubit, DocumentariesState>(
      builder: (context, state) {
        return switch (state) {
          DocumentariesLoading() => const Center(child: CircularProgressIndicator()),
          DocumentariesError() => Center(child: Text(state.message)),
          DocumentariesLoaded() => (state.documentaries.isEmpty)
              ? const Center(child: Text('No documentaries found'))
              : DocumentaryCarousel(documentaries: state.documentaries),
        };
      },
    );
  }
}

class DocumentaryCarousel extends StatelessWidget {
  final List<DocumentarySummary> documentaries;

  const DocumentaryCarousel({
    required this.documentaries,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.6,
        enlargeCenterPage: true,
        viewportFraction: 0.7,
        enableInfiniteScroll: false,
      ),
      items: documentaries
          .map((documentary) => DocumentaryCard(
                documentary: documentary,
                onTap: () {
                  context.goNamed(
                    Routes.documentary.name,
                    pathParameters: {'id': documentary.id},
                  );
                },
              ))
          .toList(),
    );
  }
}
