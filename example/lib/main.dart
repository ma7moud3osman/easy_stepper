import 'package:example/widgets/fixed_stepper.dart';
import 'package:example/widgets/icon_stepper_progress.dart';
import 'package:example/widgets/image_stepper.dart';
import 'package:example/widgets/reached_steps_stepper.dart';
import 'package:example/widgets/top_titles_stepper.dart';
import 'package:example/widgets/vertical_stepper.dart';
import 'package:flutter/material.dart';

import 'widgets/square_stepper.dart';

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
  Widget build(BuildContext _) {
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
        appBar: AppBar(
          title: const Text('Easy Stepper'),
        ),
        body: Builder(
          builder: (context) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    NavigatorButton(
                      title: 'Image Stepper',
                      screen: ImageStepper(),
                    ),
                    SizedBox(height: 20),
                    NavigatorButton(
                      title: 'Icon Steppers (Progress)',
                      screen: IconStepperProgress(),
                    ),
                    SizedBox(height: 20),
                    NavigatorButton(
                      title: 'Tapping Reached Steps Stepper',
                      screen: ReachedStepsStepper(),
                    ),
                    SizedBox(height: 20),
                    NavigatorButton(
                      title: 'Top Title Stepper',
                      screen: TopTitleStepper(),
                    ),
                    SizedBox(height: 20),
                    NavigatorButton(
                      title: 'Fixed Stepper',
                      screen: FixedStepper(),
                    ),
                    SizedBox(height: 20),
                    NavigatorButton(
                      title: 'Square Stepper',
                      screen: SquareStepper(),
                    ),
                    SizedBox(height: 20),
                    NavigatorButton(
                      title: 'Vertical Stepper',
                      screen: VerticalStepper(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class NavigatorButton extends StatelessWidget {
  final String title;
  final Widget screen;
  const NavigatorButton({
    super.key,
    required this.title,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => screen,
          ),
        );
      },
      child: Text(title),
    );
  }
}

enum StepEnabling { sequential, individual }
