import 'package:flutter/material.dart';

import '../../../../modules/documentary_catalog/application/documentary_detail.dart';
import '../../../theme/sizes.dart';
import 'documentary_duration.dart';
import 'documentary_header.dart';
import 'documentary_release_year.dart';

class DocumentaryDescription extends StatelessWidget {
  final DocumentaryDetail documentary;

  const DocumentaryDescription({
    super.key,
    required this.documentary,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        DocumentaryHeader(documentary: documentary),
        Container(
            padding: const EdgeInsets.all(Sizes.s24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DocumentaryReleaseYear(releaseYear: documentary.releaseYear),
                    DocumentaryDuration(duration: documentary.duration),
                  ],
                ),
                gapH32,
                Text(
                  documentary.synopsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                gapH64,
              ],
            ))
      ]),
    );
  }
}
