import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

/// Demonstrates [EasyStepper.verticalAlignment], which controls the horizontal
/// alignment of the steps in a vertical stepper (start / center / end).
class VerticalAlignmentStepper extends StatefulWidget {
  const VerticalAlignmentStepper({super.key});

  @override
  State<VerticalAlignmentStepper> createState() =>
      _VerticalAlignmentStepperState();
}

class _VerticalAlignmentStepperState extends State<VerticalAlignmentStepper> {
  int activeStep = 1;
  CrossAxisAlignment alignment = CrossAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vertical Alignment')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<CrossAxisAlignment>(
              segments: const [
                ButtonSegment(
                  value: CrossAxisAlignment.start,
                  label: Text('Start'),
                ),
                ButtonSegment(
                  value: CrossAxisAlignment.center,
                  label: Text('Center'),
                ),
                ButtonSegment(
                  value: CrossAxisAlignment.end,
                  label: Text('End'),
                ),
              ],
              selected: {alignment},
              onSelectionChanged: (s) => setState(() => alignment = s.first),
            ),
          ),
          Expanded(
            child: EasyStepper(
              activeStep: activeStep,
              direction: Axis.vertical,
              verticalAlignment: alignment,
              showLoadingAnimation: false,
              stepRadius: 24,
              finishedStepBackgroundColor: const Color(0xFF7C3AED),
              activeStepBackgroundColor: const Color(0xFF7C3AED),
              lineStyle: const LineStyle(
                lineType: LineType.dotted,
                unreachedLineType: LineType.dashed,
              ),
              onStepReached: (index) => setState(() => activeStep = index),
              steps: const [
                EasyStep(
                    icon: Icon(Icons.shopping_cart), title: 'Order placed'),
                EasyStep(icon: Icon(Icons.verified), title: 'Confirmed'),
                EasyStep(icon: Icon(Icons.inventory_2), title: 'Preparing'),
                EasyStep(icon: Icon(Icons.local_shipping), title: 'Shipped'),
                EasyStep(icon: Icon(Icons.home), title: 'Delivered'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
