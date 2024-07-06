import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DocumentaryMainImage extends StatelessWidget {
  final String imageUrl;

  const DocumentaryMainImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: MediaQuery.of(context).size.height * 0.6,
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
