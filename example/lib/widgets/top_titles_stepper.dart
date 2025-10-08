import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class TopTitleStepper extends StatefulWidget {
  const TopTitleStepper({super.key});

  @override
  State<TopTitleStepper> createState() => _TopTitleStepperState();
}

class _TopTitleStepperState extends State<TopTitleStepper> {
  int activeStep = 0;
  late final colorScheme = Theme.of(context).colorScheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top & Bottom Title Stepper'),
      ),
      body: EasyStepper(
        activeStep: activeStep,
        lineStyle: const LineStyle(
          lineLength: 70,
          lineSpace: 0,
          lineType: LineType.normal,
          defaultLineColor: Colors.lightBlue,
          finishedLineColor: Colors.orange,
          lineThickness: 1.5,
        ),
        activeStepTextColor: Colors.black87,
        finishedStepTextColor: Colors.black87,
        titlesAreLargerThanSteps: true,
        internalPadding: 0,
        showLoadingAnimation: false,
        stepRadius: 8,
        showStepBorder: false,
        maxTitleLines: 3,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        steps: [
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: 0 <= activeStep
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            placeTitleAtStart: true,
            title: "Waiting for Authoring",
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: 1 <= activeStep
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            title: "Authorized by Admin",
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: 2 <= activeStep
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            placeTitleAtStart: true,
            title: "Received by Warehouse",
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: 3 <= activeStep
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            title: "Under processing",
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: 4 <= activeStep
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            placeTitleAtStart: true,
            title: "Awaiting customer approval",
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: 5 <= activeStep
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            title: "Approved by customer",
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: 6 <= activeStep
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            placeTitleAtStart: true,
            title: "Confirmed",
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: 7 <= activeStep
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            title: "In preparation",
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: 8 <= activeStep
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            title: "Shipped",
            placeTitleAtStart: true,
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: 9 <= activeStep
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            title: "Delivered",
          ),
        ],
        onStepReached: (index) => setState(() => activeStep = index),
      ),
    );
  }
}
