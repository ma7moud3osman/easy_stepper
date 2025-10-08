import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class ImageStepper extends StatefulWidget {
  const ImageStepper({super.key});

  @override
  State<ImageStepper> createState() => _ImageStepperState();
}

class _ImageStepperState extends State<ImageStepper> {
  int activeStep = 0;
  final dashImages = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Stepper'),
      ),
      body: Column(
        children: [
          EasyStepper(
            activeStep: activeStep,
            lineStyle: const LineStyle(
              lineLength: 50,
              lineType: LineType.normal,
              lineThickness: 4,
              lineSpace: 1,
              lineWidth: 10,
              unreachedLineType: LineType.dashed,
            ),
            stepShape: StepShape.rRectangle,
            stepBorderRadius: 15,
            borderThickness: 2,
            internalPadding: 16,
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    dashImages[activeStep],
                    height: 150,
                  ),
                  const SizedBox(height: 5),
                  Text('Dash Step Number : ${activeStep + 1}')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
