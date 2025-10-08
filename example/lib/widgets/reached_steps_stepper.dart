import 'package:easy_stepper/easy_stepper.dart';
import 'package:example/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReachedStepsStepper extends StatefulWidget {
  const ReachedStepsStepper({super.key});

  @override
  State<ReachedStepsStepper> createState() => _ReachedStepsStepperState();
}

class _ReachedStepsStepperState extends State<ReachedStepsStepper> {
  int activeStep2 = 0;
  int reachedStep = 0;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};
  int upperBound = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reached Steps Stepper'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 2, child: _previousStep(StepEnabling.sequential)),
            Expanded(
              flex: 15,
              child: EasyStepper(
                activeStep: activeStep2,
                maxReachedStep: reachedStep,
                lineStyle: LineStyle(
                  lineLength: 100,
                  lineSpace: 4,
                  lineType: LineType.normal,
                  unreachedLineColor: Colors.grey.withValues(alpha: 0.5),
                  finishedLineColor: Colors.deepOrange,
                  activeLineColor: Colors.grey.withValues(alpha: 0.5),
                ),
                activeStepBorderColor: Colors.purple,
                activeStepIconColor: Colors.purple,
                activeStepTextColor: Colors.purple,
                activeStepBackgroundColor: Colors.white,
                unreachedStepBackgroundColor:
                    Colors.grey.withValues(alpha: 0.5),
                unreachedStepBorderColor: Colors.grey.withValues(alpha: 0.5),
                unreachedStepIconColor: Colors.grey,
                unreachedStepTextColor: Colors.grey.withValues(alpha: 0.5),
                finishedStepBackgroundColor: Colors.deepOrange,
                finishedStepBorderColor: Colors.grey.withValues(alpha: 0.5),
                finishedStepIconColor: Colors.grey,
                finishedStepTextColor: Colors.deepOrange,
                borderThickness: 10,
                internalPadding: 15,
                showLoadingAnimation: false,
                steps: [
                  EasyStep(
                    icon: const Icon(CupertinoIcons.cart),
                    title: 'Cart',
                    lineText: 'Add Address Info',
                    enabled: _allowTabStepping(0, StepEnabling.sequential),
                  ),
                  EasyStep(
                    icon: const Icon(CupertinoIcons.info),
                    title: 'Address',
                    lineText: 'Go To Checkout',
                    enabled: _allowTabStepping(1, StepEnabling.sequential),
                  ),
                  EasyStep(
                    icon: const Icon(CupertinoIcons.cart_fill_badge_plus),
                    title: 'Checkout',
                    lineText: 'Choose Payment Method',
                    enabled: _allowTabStepping(2, StepEnabling.sequential),
                  ),
                  EasyStep(
                    icon: const Icon(CupertinoIcons.money_dollar),
                    title: 'Payment',
                    lineText: 'Confirm Order Items',
                    enabled: _allowTabStepping(3, StepEnabling.sequential),
                  ),
                  EasyStep(
                    icon: const Icon(Icons.file_present_rounded),
                    title: 'Order Details',
                    lineText: 'Submit Order',
                    enabled: _allowTabStepping(4, StepEnabling.sequential),
                  ),
                  EasyStep(
                    icon: const Icon(Icons.check_circle_outline),
                    title: 'Finish',
                    enabled: _allowTabStepping(5, StepEnabling.sequential),
                  ),
                ],
                onStepReached: (index) => setState(() {
                  activeStep2 = index;
                }),
              ),
            ),
            Expanded(flex: 2, child: _nextStep(StepEnabling.sequential)),
          ],
        ),
      ),
    );
  }

  bool _allowTabStepping(int index, StepEnabling enabling) {
    return enabling == StepEnabling.sequential
        ? index <= reachedStep
        : reachedSteps.contains(index);
  }

  /// Returns the next button.
  Widget _nextStep(StepEnabling enabling) {
    return IconButton(
      onPressed: () {
        if (activeStep2 < upperBound) {
          setState(() {
            if (enabling == StepEnabling.sequential) {
              ++activeStep2;
              if (reachedStep < activeStep2) {
                reachedStep = activeStep2;
              }
            } else {
              activeStep2 =
                  reachedSteps.firstWhere((element) => element > activeStep2);
            }
          });
        }
      },
      iconSize: 18,
      icon: const Icon(Icons.arrow_forward_ios),
    );
  }

  /// Returns the previous button.
  Widget _previousStep(StepEnabling enabling) {
    return IconButton(
      onPressed: () {
        if (activeStep2 > 0) {
          setState(() => enabling == StepEnabling.sequential
              ? --activeStep2
              : activeStep2 =
                  reachedSteps.lastWhere((element) => element < activeStep2));
        }
      },
      iconSize: 18,
      icon: const Icon(Icons.arrow_back_ios),
    );
  }
}
