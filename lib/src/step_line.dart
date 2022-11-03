import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class StepLine extends StatelessWidget {
  const StepLine({
    Key? key,
    required this.isFinished,
    this.finishedLineColor,
    this.unreachedLineColor,
  }) : super(key: key);

  final bool isFinished;
  final Color? finishedLineColor;
  final Color? unreachedLineColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 60,
        child: DottedLine(
          dashColor: isFinished
              ? finishedLineColor ?? Theme.of(context).colorScheme.error
              : unreachedLineColor ?? const Color(0xffBABABA),
          dashLength: 2,
          dashGapLength: 2,
          lineLength: 60,
        ),
      ),
    );
  }
}
