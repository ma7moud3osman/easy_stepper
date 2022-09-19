import 'package:easy_stepper/src/components/custom_dotted_line.dart';
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
    return Expanded(
      child: Column(
        children: [
          CustomDottedLine(
            color: isFinished
                ? finishedLineColor ?? Theme.of(context).colorScheme.primary
                : unreachedLineColor ?? const Color(0xffBABABA),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
