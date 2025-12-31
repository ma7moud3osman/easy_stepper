import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class FlexibleStepper extends StatefulWidget {
  const FlexibleStepper({super.key});

  @override
  State<FlexibleStepper> createState() => _FlexibleStepperState();
}

class _FlexibleStepperState extends State<FlexibleStepper> {
  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flexible Line Stepper'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Horizontal Flexible Line\n(Fills Width)',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            EasyStepper(
              activeStep: activeStep,
              lineStyle: const LineStyle(
                lineLength: double.infinity, // Flexible
                lineType: LineType.normal,
                lineThickness: 3,
                lineSpace: 5,
                unreachedLineType: LineType.dashed,
                finishedLineColor: Colors.deepPurple,

                unreachedLineColor: Colors.grey,
              ),
              stepRadius: 20,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              unreachedStepBorderType: BorderType.normal,
              unreachedStepBorderColor: Colors.grey,
              unreachedStepTextColor: Colors.grey,
              unreachedStepIconColor: Colors.grey,
              finishedStepBorderColor: Colors.deepPurple,
              finishedStepTextColor: Colors.deepPurple,
              finishedStepBackgroundColor:
                  const Color.fromRGBO(103, 58, 183, 0.1),
              activeStepBorderColor: Colors.deepPurple,
              activeStepTextColor: Colors.deepPurple,
              activeStepIconColor: Colors.deepPurple,
              onStepReached: (index) => setState(() => activeStep = index),
              steps: const [
                EasyStep(
                  icon: Icon(Icons.start),
                  customTitle: Text(
                    'Start',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  lineText: '1.5km',
                ),
                EasyStep(
                  icon: Icon(Icons.directions_walk),
                  customTitle: Text(
                    'Walk',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  lineText: '800m',
                ),
                EasyStep(
                  icon: Icon(Icons.directions_bus),
                  customTitle: Text(
                    'Bus',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  lineText: '5km',
                ),
                EasyStep(
                  icon: Icon(Icons.flag),
                  title: 'Finish',
                ),
              ],
            ),
            const Divider(thickness: 2, height: 40),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Vertical Flexible Line\n(Fills Remaining Height)',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
              child: EasyStepper(
                activeStep: activeStep,
                direction: Axis.vertical,
                lineStyle: const LineStyle(
                  lineLength: double.infinity, // Flexible
                  lineType: LineType.normal,
                  lineThickness: 4,
                  lineSpace: 0,
                  finishedLineColor: Colors.teal,
                  unreachedLineColor: Colors.grey,
                ),
                stepRadius: 15,
                internalPadding: 0,
                padding: EdgeInsets.zero,
                unreachedStepBorderType: BorderType.dotted,
                finishedStepBorderColor: Colors.teal,
                finishedStepTextColor: Colors.teal,
                activeStepBorderColor: Colors.teal,
                activeStepTextColor: Colors.teal,
                activeStepIconColor: Colors.teal,
                onStepReached: (index) => setState(() => activeStep = index),
                steps: const [
                  EasyStep(
                    icon: Icon(Icons.account_circle),
                    title: 'Account',
                    lineText: 'cart',
                  ),
                  EasyStep(
                    icon: Icon(Icons.info),
                    title: 'Info',
                  ),
                  EasyStep(
                    icon: Icon(Icons.local_shipping),
                    title: 'Shipping',
                  ),
                  EasyStep(
                    icon: Icon(Icons.payment),
                    title: 'Payment',
                  ),
                  EasyStep(
                    icon: Icon(Icons.check_circle),
                    title: 'Complete',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
