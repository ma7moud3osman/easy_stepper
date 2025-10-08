import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalStepper extends StatefulWidget {
  const VerticalStepper({super.key});

  @override
  State<VerticalStepper> createState() => _VerticalStepperState();
}

class _VerticalStepperState extends State<VerticalStepper> {
  int activeStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vertical Stepper'),
      ),
      body: EasyStepper(
        lineStyle: const LineStyle(
          lineType: LineType.normal,
          // lineThickness: 250,
        ),
        activeStep: activeStep,
        direction: Axis.vertical,
        unreachedStepIconColor: Colors.white,
        unreachedStepBorderColor: Colors.black54,
        finishedStepBackgroundColor: Colors.deepPurple,
        unreachedStepBackgroundColor: Colors.deepOrange,
        // showTitle: false,
        onStepReached: (index) => setState(() => activeStep = index),
        padding: EdgeInsets.zero,
        showTitle: true,
        steps: const [
          EasyStep(
            title: 'Cart Info',
            icon: Icon(CupertinoIcons.cart),
            activeIcon: Icon(CupertinoIcons.cart),
            lineText: 'Cart Line',
            placeTitleAtStart: false,
          ),
          EasyStep(
            icon: Icon(Icons.file_present),
            activeIcon: Icon(Icons.file_present),
            title: 'Address',
          ),
          EasyStep(
            icon: Icon(Icons.filter_center_focus_sharp),
            activeIcon: Icon(Icons.filter_center_focus_sharp),
            title: 'Checkout',
          ),
          EasyStep(
            icon: Icon(Icons.money),
            activeIcon: Icon(Icons.money),
            title: 'Payment',
          ),
          EasyStep(
            icon: Icon(Icons.local_shipping_outlined),
            activeIcon: Icon(Icons.local_shipping_outlined),
            title: 'Shipping',
          ),
          EasyStep(
            icon: Icon(Icons.file_copy_outlined),
            activeIcon: Icon(Icons.file_copy_outlined),
            title: 'Order Details',
          ),
          EasyStep(
            icon: Icon(Icons.check_circle_outline),
            activeIcon: Icon(Icons.check_circle_outline),
            title: 'Finish',
          ),
        ],
      ),
    );
  }
}
