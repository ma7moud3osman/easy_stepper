import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int activeStep = 0;
  final icons = [
    const Icon(CupertinoIcons.cart),
    const Icon(CupertinoIcons.info),
    const Icon(CupertinoIcons.cart_fill_badge_plus),
    const Icon(CupertinoIcons.money_dollar),
    const Icon(Icons.file_present_rounded),
    const Icon(Icons.check_circle_outline),
    const Icon(Icons.check_circle_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                EasyStepper(
                  activeStep: activeStep,
                  lineLength: 90,
                  lineType: LineType.normal,
                  steps: const [
                    EasyStep(
                      icon: Icon(CupertinoIcons.cart),
                      title: 'Cart',
                      finishIcon: Icon(Icons.check_circle_outline_rounded),
                      lineText: 'First Line',
                    ),
                    EasyStep(
                      icon: Icon(CupertinoIcons.info),
                      title: 'Address',
                    ),
                    EasyStep(
                      icon: Icon(CupertinoIcons.cart_fill_badge_plus),
                      title: 'Checkout',
                    ),
                    EasyStep(
                      icon: Icon(CupertinoIcons.money_dollar),
                      title: 'Payment',
                    ),
                    EasyStep(
                      icon: Icon(Icons.file_present_rounded),
                      title: 'Order Details',
                    ),
                    EasyStep(
                      icon: Icon(Icons.check_circle_outline),
                      title: 'Finish',
                    ),
                  ],
                  onStepReached: (index) => setState(() => activeStep = index),
                ),
                Expanded(
                  child: Icon(
                    icons[activeStep].icon,
                    size: 180,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
