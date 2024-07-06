import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedPrice extends StatelessWidget {
  final double price;
  final TextStyle? style;
  final TextAlign? textAlign;

  const FormattedPrice({
    super.key,
    required this.price,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.simpleCurrency(locale: "en_US");

    return Text(
      currencyFormatter.format(price),
      textAlign: textAlign,
      style: style,
    );
  }
}
