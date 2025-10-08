import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FixedStepper extends StatefulWidget {
  const FixedStepper({super.key});

  @override
  State<FixedStepper> createState() => _FixedStepperState();
}

class _FixedStepperState extends State<FixedStepper> {
  int activeStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixed Stepper'),
      ),
      body: EasyStepper(
        activeStep: activeStep,
        lineStyle: const LineStyle(
          lineLength: 80,
          lineThickness: 1,
          lineSpace: 5,
        ),
        stepRadius: 20,
        unreachedStepIconColor: Colors.black87,
        unreachedStepBorderColor: Colors.black54,
        unreachedStepTextColor: Colors.black,
        showLoadingAnimation: false,
        steps: const [
          EasyStep(
            icon: Icon(Icons.my_location),
            title: 'You',
            lineText: '1.7 KM',
          ),
          EasyStep(
            icon: Icon(CupertinoIcons.cube_box),
            title: 'Pick Up',
            lineText: '3 KM',
          ),
          EasyStep(
            icon: Icon(CupertinoIcons.flag),
            title: 'Drop Off',
          ),
        ],
        onStepReached: (index) => setState(() => activeStep = index),
      ),
    );
  }
}
