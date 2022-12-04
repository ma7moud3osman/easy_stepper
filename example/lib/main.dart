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
                      activeIcon: Icon(CupertinoIcons.cart),
                      title: 'Cart',
                      finishIcon: Icon(Icons.check_circle_outline_rounded),
                    ),
                    EasyStep(
                      icon: Icon(CupertinoIcons.info),
                      activeIcon: Icon(CupertinoIcons.info),
                      title: 'Address',
                    ),
                    EasyStep(
                      icon: Icon(CupertinoIcons.cart_fill_badge_plus),
                      activeIcon: Icon(CupertinoIcons.cart_fill_badge_plus),
                      title: 'Checkout',
                    ),
                    EasyStep(
                      icon: Icon(CupertinoIcons.money_dollar),
                      activeIcon: Icon(CupertinoIcons.money_dollar),
                      title: 'Payment',
                    ),
                    EasyStep(
                      icon: Icon(Icons.file_present_rounded),
                      activeIcon: Icon(Icons.file_present_rounded),
                      title: 'Order Details',
                    ),
                    EasyStep(
                      icon: Icon(Icons.check_circle_outline),
                      activeIcon: Icon(Icons.check_circle_outline),
                      title: 'Finish',
                    ),
                  ],
                  onStepReached: (index) => setState(() => activeStep = index),
                ),
                const SizedBox(height: 50),
                EasyStepper(
                  activeStep: activeStep,
                  lineLength: 90,
                  lineDotRadius: 1,
                  lineSpace: 5,
                  steps: const [
                    EasyStep(
                      icon: Icon(CupertinoIcons.cart),
                      title: 'Cart',
                      lineText: 'First Line',
                    ),
                    EasyStep(
                      icon: Icon(CupertinoIcons.info),
                      title: 'Address',
                      lineText: 'Second Line',
                    ),
                    EasyStep(
                      icon: Icon(CupertinoIcons.cart_fill_badge_plus),
                      title: 'Checkout',
                      lineText: 'Third Line',
                    ),
                    EasyStep(
                      icon: Icon(CupertinoIcons.money_dollar),
                      title: 'Payment',
                      lineText: 'Fourth Line',
                    ),
                    EasyStep(
                      icon: Icon(Icons.file_present_rounded),
                      title: 'Order Details',
                      lineText: 'Fifth Line',
                    ),
                    EasyStep(
                      icon: Icon(Icons.check_circle_outline),
                      title: 'Finish',
                      lineText: 'Last Line',
                    ),
                  ],
                  onStepReached: (index) => setState(() => activeStep = index),
                ),
                const SizedBox(height: 50),
                EasyStepper(
                  activeStep: -1,
                  lineLength: 80,
                  lineDotRadius: 1,
                  lineSpace: 5,
                  stepRadius: 20,
                  unreachedStepIconColor: Colors.black87,
                  unreachedStepBorderColor: Colors.black54,
                  unreachedStepTextColor: Colors.black,
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
                Row(
                  children: [
                    const SizedBox(height: 60),
                    SizedBox(
                      height: 400,
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          EasyStepper(
                            lineType: LineType.normal,
                            activeStep: activeStep,
                            direction: Axis.vertical,
                            unreachedStepIconColor: Colors.white,
                            unreachedStepBorderColor: Colors.black54,
                            finishedStepBackgroundColor: Colors.deepPurple,
                            activeStepBackgroundColor: Colors.purple,
                            unreachedStepBackgroundColor: Colors.deepOrange,
                            showTitle: false,
                            onStepReached: (index) =>
                                setState(() => activeStep = index),
                            steps: const [
                              EasyStep(
                                icon: Icon(CupertinoIcons.cart),
                                title: 'Cart',
                                activeIcon: Icon(CupertinoIcons.cart),
                                lineText: 'Cart Line',
                              ),
                              EasyStep(
                                icon: Icon(Icons.file_present),
                                activeIcon: Icon(Icons.file_present),
                                title: 'Address',
                              ),
                              EasyStep(
                                icon: Icon(Icons.filter_center_focus_sharp),
                                activeIcon:
                                    Icon(Icons.filter_center_focus_sharp),
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
                          const SizedBox(width: 60),
                          Container(
                            width: 200,
                            height: 600,
                            color: Colors.deepPurple,
                          ),
                        ],
                      ),
                    ),
                  ],
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
