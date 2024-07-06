import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../composition_root.dart';
import '../../router.dart';
import 'cubit/documentary_detail_cubit.dart';
import 'widgets/documentary_description.dart';
import 'widgets/documentary_main_image.dart';
import 'widgets/purchase_button.dart';

class DocumentaryDetailScreen extends StatelessWidget {
  final String documentaryId;

  const DocumentaryDetailScreen({
    super.key,
    required this.documentaryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DocumentaryDetailCubit>()..loadDocumentaryById(documentaryId),
      child: BlocBuilder<DocumentaryDetailCubit, DocumentaryDetailState>(
        builder: (context, state) {
          return switch (state) {
            DocumentaryDetailLoading() => const DocumentaryDetailLoadingWidget(),
            DocumentaryDetailError() => DocumentaryDetailErrorWidget(state),
            DocumentaryDetailLoaded() => DocumentaryDetailLoadedWidget(state)
          };
        },
      ),
    );
  }
}

class DocumentaryDetailLoadingWidget extends StatelessWidget {
  const DocumentaryDetailLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class DocumentaryDetailErrorWidget extends StatelessWidget {
  final DocumentaryDetailError state;

  const DocumentaryDetailErrorWidget(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(child: Text(state.message)),
      ),
    );
  }
}

class DocumentaryDetailLoadedWidget extends StatelessWidget {
  final DocumentaryDetailLoaded state;

  const DocumentaryDetailLoadedWidget(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            DocumentaryMainImage(imageUrl: state.documentary.mainImageUrl),
            DocumentaryDescription(documentary: state.documentary),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: PurchaseButton(
        documentary: state.documentary,
        onTap: () {
          context.goNamed(
            Routes.checkout.name,
            pathParameters: {'id': state.documentary.id},
          );
        },
      ),
    );
  }
}
