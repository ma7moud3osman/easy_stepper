import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconStepperProgress extends StatefulWidget {
  const IconStepperProgress({super.key});

  @override
  State<IconStepperProgress> createState() => _IconStepperProgressState();
}

class _IconStepperProgressState extends State<IconStepperProgress> {
  int activeStep = 0;
  double progress = 0.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon Stepper Progress'),
      ),
      body: EasyStepper(
        activeStep: activeStep,
        lineStyle: LineStyle(
            lineLength: 100,
            lineThickness: 8,
            lineSpace: 4,
            lineType: LineType.normal,
            defaultLineColor: Colors.purple.shade100,
            progress: progress,
            progressColor: Colors.purple.shade800,
            borderRadius: BorderRadius.circular(500)),
        borderThickness: 10,
        internalPadding: 15,
        loadingAnimation: 'assets/loading_circle.json',
        stepBorderRadius: 50,
        maxTitleLines: 1,
        padding: const EdgeInsets.all(0),
        steps: const [
          EasyStep(
            icon: Icon(CupertinoIcons.cart),
            title: 'Cart',
            lineText: 'Add Address Info',
          ),
          EasyStep(
            icon: Icon(CupertinoIcons.info),
            title: 'Address',
            lineText: 'Go To Checkout',
          ),
          EasyStep(
            icon: Icon(CupertinoIcons.cart_fill_badge_plus),
            title: 'Checkout',
            lineText: 'Choose Payment Method',
          ),
          EasyStep(
            icon: Icon(CupertinoIcons.money_dollar),
            title: 'Payment',
            lineText: 'Confirm Order Items',
          ),
          EasyStep(
            icon: Icon(Icons.file_present_rounded),
            title: 'Order Details',
            lineText: 'Submit Order',
          ),
          EasyStep(
            icon: Icon(Icons.check_circle_outline),
            title: 'Finish',
          ),
        ],
        onStepReached: (index) => setState(() {
          activeStep = index;
          progress = 0.1;
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increaseProgress,
        child: const Icon(Icons.add),
      ),
    );
  }

  void increaseProgress() {
    if (progress < 1) {
      setState(() => progress += 0.2);
    } else {
      setState(() => progress = 0);
    }
  }
}
