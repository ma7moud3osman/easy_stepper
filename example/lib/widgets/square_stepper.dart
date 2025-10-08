import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class SquareStepper extends StatefulWidget {
  const SquareStepper({super.key});

  @override
  State<SquareStepper> createState() => _SquareStepperState();
}

class _SquareStepperState extends State<SquareStepper> {
  int activeStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Square Stepper'),
      ),
      body: Material(
        child: EasyStepper(
          activeStep: activeStep,
          lineStyle: LineStyle(
            lineLength: 70,
            lineSpace: 0,
            defaultLineColor: Colors.grey.shade200,
          ),
          stepRadius: 15,
          stepShape: StepShape.rRectangle,
          showStepBorder: false,
          stepBorderRadius: 4,
          finishedStepBackgroundColor: Colors.orange,
          activeStepBackgroundColor: Colors.orange,
          unreachedStepBackgroundColor: Colors.grey.shade200,
          showLoadingAnimation: false,
          internalPadding: 0,
          steps: const [
            EasyStep(
              customStep: Text('1'),
            ),
            EasyStep(
              customStep: Text('2'),
            ),
            EasyStep(
              customStep: Text('3'),
            ),
          ],
          onStepReached: (index) => setState(() => activeStep = index),
        ),
      ),
    );
  }
}
