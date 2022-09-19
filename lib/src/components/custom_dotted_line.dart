import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class CustomDottedLine extends StatelessWidget {
  const CustomDottedLine({
    Key? key,
    this.color,
  }) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      dashColor: color ?? Theme.of(context).colorScheme.primary,
      dashLength: 2,
      dashGapLength: 2,
    );
  }
}
