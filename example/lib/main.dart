import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  int activeStep2 = 0;
  int reachedStep = 0;
  int upperBound = 5;
  double progress = 0.2;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};
  final dashImages = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
  ];

  void increaseProgress() {
    if (progress < 1) {
      setState(() => progress += 0.2);
    } else {
      setState(() => progress = 0);
    }
  }

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
                  lineStyle: const LineStyle(
                    lineLength: 50,
                    lineType: LineType.normal,
                    lineThickness: 3,
                    lineSpace: 1,
                    lineWidth: 10,
                    unreachedLineType: LineType.dashed,
                  ),
                  stepShape: StepShape.rRectangle,
                  stepBorderRadius: 15,
                  borderThickness: 2,
                  internalPadding: 10,
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
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
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Image.asset(
                        dashImages[activeStep],
                        height: 150,
                      ),
                      const SizedBox(height: 5),
                      Text('Dash ${activeStep + 1}')
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                EasyStepper(
                  activeStep: activeStep,
                  lineStyle: LineStyle(
                    lineLength: 100,
                    lineThickness: 6,
                    lineSpace: 4,
                    lineType: LineType.normal,
                    defaultLineColor: Colors.purple.shade300,
                    progress: progress,
                    // progressColor: Colors.purple.shade700,
                  ),
                  borderThickness: 10,
                  internalPadding: 15,
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
                const SizedBox(height: 20),

                ///example with step tapping only on already reached steps
                SizedBox(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: _previousStep(StepEnabling.sequential)),
                      Expanded(
                        flex: 15,
                        child: EasyStepper(
                          activeStep: activeStep2,
                          maxReachedStep: reachedStep,
                          lineStyle: LineStyle(
                            lineLength: 100,
                            lineSpace: 4,
                            lineType: LineType.normal,
                            unreachedLineColor: Colors.grey.withOpacity(0.5),
                            finishedLineColor: Colors.deepOrange,
                            activeLineColor: Colors.grey.withOpacity(0.5),
                          ),
                          activeStepBorderColor: Colors.purple,
                          activeStepIconColor: Colors.purple,
                          activeStepTextColor: Colors.purple,
                          activeStepBackgroundColor: Colors.white,
                          unreachedStepBackgroundColor:
                              Colors.grey.withOpacity(0.5),
                          unreachedStepBorderColor:
                              Colors.grey.withOpacity(0.5),
                          unreachedStepIconColor: Colors.grey,
                          unreachedStepTextColor: Colors.grey.withOpacity(0.5),
                          finishedStepBackgroundColor: Colors.deepOrange,
                          finishedStepBorderColor: Colors.grey.withOpacity(0.5),
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
                              enabled:
                                  _allowTabStepping(0, StepEnabling.sequential),
                            ),
                            EasyStep(
                              icon: const Icon(CupertinoIcons.info),
                              title: 'Address',
                              lineText: 'Go To Checkout',
                              enabled:
                                  _allowTabStepping(1, StepEnabling.sequential),
                            ),
                            EasyStep(
                              icon: const Icon(
                                  CupertinoIcons.cart_fill_badge_plus),
                              title: 'Checkout',
                              lineText: 'Choose Payment Method',
                              enabled:
                                  _allowTabStepping(2, StepEnabling.sequential),
                            ),
                            EasyStep(
                              icon: const Icon(CupertinoIcons.money_dollar),
                              title: 'Payment',
                              lineText: 'Confirm Order Items',
                              enabled:
                                  _allowTabStepping(3, StepEnabling.sequential),
                            ),
                            EasyStep(
                              icon: const Icon(Icons.file_present_rounded),
                              title: 'Order Details',
                              lineText: 'Submit Order',
                              enabled:
                                  _allowTabStepping(4, StepEnabling.sequential),
                            ),
                            EasyStep(
                              icon: const Icon(Icons.check_circle_outline),
                              title: 'Finish',
                              enabled:
                                  _allowTabStepping(5, StepEnabling.sequential),
                            ),
                          ],
                          onStepReached: (index) => setState(() {
                            activeStep2 = index;
                          }),
                        ),
                      ),
                      Expanded(
                          flex: 1, child: _nextStep(StepEnabling.sequential)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1, child: _previousStep(StepEnabling.individual)),
                    Expanded(
                      flex: 15,
                      child: EasyStepper(
                        activeStep: activeStep2,
                        reachedSteps: reachedSteps,
                        lineStyle: LineStyle(
                          lineLength: 100,
                          lineSpace: 4,
                          lineType: LineType.dotted,
                          finishedLineColor: Colors.pink.withOpacity(0.5),
                          unreachedLineColor: Colors.blueGrey.withOpacity(0.5),
                          activeLineColor: Colors.blueGrey.withOpacity(0.5),
                        ),
                        activeStepBorderColor: Colors.blue,
                        activeStepIconColor: Colors.blue,
                        activeStepTextColor: Colors.blue,
                        activeStepBackgroundColor: Colors.white,
                        unreachedStepBackgroundColor:
                            Colors.blueGrey.withOpacity(0.5),
                        unreachedStepBorderColor:
                            Colors.blueGrey.withOpacity(0.5),
                        unreachedStepIconColor: Colors.blueGrey,
                        unreachedStepTextColor:
                            Colors.blueGrey.withOpacity(0.5),
                        finishedStepBackgroundColor:
                            Colors.pink.withOpacity(0.5),
                        finishedStepBorderColor:
                            Colors.blueGrey.withOpacity(0.5),
                        finishedStepIconColor: Colors.blueGrey,
                        finishedStepTextColor: Colors.pink.withOpacity(0.5),
                        borderThickness: 2,
                        internalPadding: 15,
                        showStepBorder: true,
                        showLoadingAnimation: false,
                        stepRadius: 20,
                        // stepShape: baseStep.StepShape.rRectangle,
                        showTitle: true,
                        steps: [
                          EasyStep(
                            icon: const Icon(CupertinoIcons.cart),
                            title: 'Cart',
                            lineText: 'Add Address Info',
                            enabled:
                                _allowTabStepping(0, StepEnabling.individual),
                            // showBadge: true,
                          ),
                          EasyStep(
                            icon: const Icon(CupertinoIcons.info),
                            title: 'Address',
                            lineText: 'Go To Checkout',
                            enabled:
                                _allowTabStepping(1, StepEnabling.individual),
                          ),
                          EasyStep(
                            icon:
                                const Icon(CupertinoIcons.cart_fill_badge_plus),
                            title: 'Checkout',
                            lineText: 'Choose Payment Method',
                            enabled:
                                _allowTabStepping(2, StepEnabling.individual),
                          ),
                          EasyStep(
                            icon: const Icon(CupertinoIcons.money_dollar),
                            title: 'Payment',
                            lineText: 'Confirm Order Items',
                            enabled:
                                _allowTabStepping(3, StepEnabling.individual),
                          ),
                          EasyStep(
                            icon: const Icon(Icons.file_present_rounded),
                            title: 'Order Details',
                            lineText: 'Submit Order',
                            enabled:
                                _allowTabStepping(4, StepEnabling.individual),
                          ),
                          EasyStep(
                            icon: const Icon(Icons.check_circle_outline),
                            title: 'Finish',
                            enabled:
                                _allowTabStepping(5, StepEnabling.individual),
                          ),
                        ],
                        onStepReached: (index) => setState(() {
                          activeStep2 = index;
                        }),
                      ),
                    ),
                    Expanded(
                        flex: 1, child: _nextStep(StepEnabling.individual)),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 35),
                  color: Colors.grey.shade200,
                  clipBehavior: Clip.none,
                  child: EasyStepper(
                    activeStep: activeStep,
                    lineStyle: const LineStyle(
                      lineLength: 70,
                      lineSpace: 0,
                      lineType: LineType.normal,
                      defaultLineColor: Colors.white,
                      finishedLineColor: Colors.orange,
                      lineThickness: 1.5,
                    ),
                    activeStepTextColor: Colors.black87,
                    finishedStepTextColor: Colors.black87,
                    internalPadding: 0,
                    showLoadingAnimation: false,
                    stepRadius: 8,
                    showStepBorder: false,
                    steps: [
                      EasyStep(
                          enabled: 0 <= activeStep + 1,
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: 0 <= activeStep ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          topTitle: 0 % 2 == 1,
                          title: "Awaiting authorization",
                          customTitle: const SizedBox(
                            width: double.infinity,
                            child: Text("Awaiting authorization", textAlign: TextAlign.center),
                          )
                      ),
                      EasyStep(
                          enabled: 1 <= activeStep + 1,
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: 1 <= activeStep ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          topTitle: 1 % 2 == 1,
                          title: "Authorized",
                          customTitle: const SizedBox(
                            width: double.infinity,
                            child: Text("Authorized", textAlign: TextAlign.center),
                          )
                      ),
                      EasyStep(
                          enabled: 2 <= activeStep + 1,
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: 2 <= activeStep ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          topTitle: 2 % 2 == 1,
                          title: "Received",
                          customTitle: const SizedBox(
                            width: double.infinity,
                            child: Text("Received", textAlign: TextAlign.center),
                          )
                      ),
                      EasyStep(
                          enabled: 3 <= activeStep + 1,
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: 3 <= activeStep ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          topTitle: 3 % 2 == 1,
                          title: "Under processing",
                          customTitle: const SizedBox(
                            width: double.infinity,
                            child: Text("Under processing", textAlign: TextAlign.center),
                          )
                      ),
                      EasyStep(
                          enabled: 4 <= activeStep + 1,
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: 4 <= activeStep ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          topTitle: 4 % 2 == 1,
                          title: "Awaiting customer approval",
                          customTitle: const SizedBox(
                            width: double.infinity,
                            child: Text("Awaiting customer approval", textAlign: TextAlign.center),
                          )
                      ),
                      EasyStep(
                          enabled: 5 <= activeStep + 1,
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: 5 <= activeStep ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          topTitle: 5 % 2 == 1,
                          title: "Approved by customer personally",
                          customTitle: const SizedBox(
                            width: double.infinity,
                            child: Text("Approved by customer personally", textAlign: TextAlign.center),
                          )
                      ),
                      EasyStep(
                          enabled: 6 <= activeStep + 1,
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: 6 <= activeStep ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          topTitle: 6 % 2 == 1,
                          title: "Confirmed",
                          customTitle: const SizedBox(
                            width: double.infinity,
                            child: Text("Confirmed", textAlign: TextAlign.center),
                          )
                      ),
                      EasyStep(
                          enabled: 7 <= activeStep + 1,
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: 7 <= activeStep ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          topTitle: 7 % 2 == 1,
                          title: "In preparation",
                          customTitle: const SizedBox(
                            width: double.infinity,
                            child: Text("In preparation", textAlign: TextAlign.center),
                          )
                      ),
                      EasyStep(
                          enabled: 8 <= activeStep + 1,
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: 8 <= activeStep ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          topTitle: 8 % 2 == 1,
                          title: "Shipped",
                          customTitle: const SizedBox(
                            width: double.infinity,
                            child: Text("Shipped", textAlign: TextAlign.center),
                          )
                      ),
                      EasyStep(
                          enabled: 9 <= activeStep + 1,
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: 9 <= activeStep ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          topTitle: 9 % 2 == 1,
                          title: "Delivered",
                          customTitle: const SizedBox(
                            width: double.infinity,
                            child: Text("Delivered", textAlign: TextAlign.center),
                          )
                      )
                    ],
                    onStepReached: (index) =>
                        setState(() => activeStep = index),
                  ),
                ),
                const SizedBox(height: 50),
                EasyStepper(
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
                const SizedBox(height: 40),
                SizedBox(
                  height: 450,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EasyStepper(
                        lineStyle: const LineStyle(
                          lineType: LineType.normal,
                          unreachedLineType: LineType.dotted,
                        ),
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
                        lineStyle: const LineStyle(
                          lineType: LineType.normal,
                        ),
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
                        lineStyle: const LineStyle(
                          lineType: LineType.normal,
                        ),
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
        floatingActionButton: FloatingActionButton(onPressed: increaseProgress),
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
      icon: const Icon(Icons.arrow_back_ios),
    );
  }
}

enum StepEnabling { sequential, individual }
