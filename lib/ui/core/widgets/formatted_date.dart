import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedDate extends StatelessWidget {
  final DateTime dateTime;
  final TextStyle? style;

  const FormattedDate({
    super.key,
    required this.dateTime,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat.yMMMMd();

    return Text(
      dateFormatter.format(dateTime),
      style: style ?? Theme.of(context).textTheme.bodySmall,
    );
  }
}
