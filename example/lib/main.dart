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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          backgroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                EasyStepper(
                  activeStep: activeStep,
                  lineLength: 50,
                  stepShape: StepShape.rRectangle,
                  stepBorderRadius: 15,
                  borderThickness: 2,
                  padding: 20,
                  stepRadius: 28,
                  finishedStepBorderColor: Colors.deepOrange,
                  finishedStepTextColor: Colors.deepOrange,
                  finishedStepBackgroundColor: Colors.deepOrange,
                  activeStepIconColor: Colors.deepOrange,
                  showLoadingAnimation: false,
                  steps: [
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 0 ? 1 : 0.3,
                          child: Image.asset('assets/1.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Dash 1',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 1 ? 1 : 0.3,
                          child: Image.asset('assets/2.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Dash 2',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 2 ? 1 : 0.3,
                          child: Image.asset('assets/3.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Dash 3',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 3 ? 1 : 0.3,
                          child: Image.asset('assets/4.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Dash 4',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 4 ? 1 : 0.3,
                          child: Image.asset('assets/5.png'),
                        ),
                      ),
                      customTitle: const Text(
                        'Dash 5',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  onStepReached: (index) => setState(() => activeStep = index),
                ),
                const SizedBox(height: 50),
                EasyStepper(
                  activeStep: activeStep,
                  lineLength: 100,
                  lineDotRadius: 3,
                  lineSpace: 4,
                  lineType: LineType.normal,
                  defaultLineColor: Colors.purple.shade300,
                  borderThickness: 10,
                  padding: 15,
                  loadingAnimation: 'assets/loading_circle.json',
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
                  onStepReached: (index) => setState(() => activeStep = index),
                ),
                const SizedBox(height: 50),
                EasyStepper(
                  activeStep: activeStep,
                  lineLength: 80,
                  lineDotRadius: 1,
                  lineSpace: 5,
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
                const SizedBox(height: 40),
                SizedBox(
                  height: 450,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EasyStepper(
                        lineType: LineType.normal,
                        activeStep: activeStep,
                        direction: Axis.vertical,
                        unreachedStepIconColor: Colors.white,
                        unreachedStepBorderColor: Colors.black54,
                        finishedStepBackgroundColor: Colors.deepPurple,
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
                      EasyStepper(
                        lineType: LineType.normal,
                        activeStep: activeStep,
                        direction: Axis.vertical,
                        unreachedStepIconColor: Colors.white,
                        unreachedStepBorderColor: Colors.black54,
                        finishedStepBackgroundColor: Colors.deepPurple,
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
                      EasyStepper(
                        lineType: LineType.normal,
                        activeStep: activeStep,
                        direction: Axis.vertical,
                        unreachedStepIconColor: Colors.white,
                        unreachedStepBorderColor: Colors.black54,
                        finishedStepBackgroundColor: Colors.deepPurple,
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
                    ],
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
