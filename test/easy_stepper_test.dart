import 'package:easy_stepper/easy_stepper.dart';
import 'package:easy_stepper/src/core/easy_border.dart';
import 'package:easy_stepper/src/core/step_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EasyStepper', () {
    testWidgets('renders horizontal stepper correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 0,
              showLoadingAnimation: false,
              steps: [
                EasyStep(icon: Icon(Icons.add), title: 'Step 1'),
                EasyStep(icon: Icon(Icons.add), title: 'Step 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(EasyStepper), findsOneWidget);
      expect(find.text('Step 1'), findsOneWidget);
    });

    testWidgets('renders vertical stepper correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 0,
              direction: Axis.vertical,
              showLoadingAnimation: false,
              steps: [
                EasyStep(icon: Icon(Icons.add), title: 'Step 1'),
                EasyStep(icon: Icon(Icons.add), title: 'Step 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(EasyStepper), findsOneWidget);
    });

    testWidgets('tapping a step triggers onStepReached',
        (WidgetTester tester) async {
      int? tappedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 0,
              enableStepTapping: true,
              showLoadingAnimation: false,
              onStepReached: (index) {
                tappedIndex = index;
              },
              steps: const [
                EasyStep(icon: Icon(Icons.add), title: 'Step 1'),
                EasyStep(icon: Icon(Icons.remove), title: 'Step 2'),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();

      expect(tappedIndex, 1);
    });

    testWidgets('displays active step status correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 1,
              showLoadingAnimation: false,
              steps: [
                EasyStep(icon: Icon(Icons.check), title: 'Step 1'),
                EasyStep(icon: Icon(Icons.check), title: 'Step 2'),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNWidgets(2));
    });

    testWidgets('renders custom steps', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 0,
              showLoadingAnimation: false,
              steps: [
                EasyStep(
                  customStep: Text('Custom 1'),
                  customTitle: Text('Title 1'),
                ),
                EasyStep(
                  customStep: Text('Custom 2'),
                  customTitle: Text('Title 2'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Custom 1'), findsOneWidget);
      expect(find.text('Title 1'), findsOneWidget);
    });

    testWidgets('handles step tapping disabled', (WidgetTester tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 0,
              enableStepTapping: false,
              showLoadingAnimation: false,
              onStepReached: (index) => tappedIndex = index,
              steps: const [
                EasyStep(icon: Icon(Icons.add), title: '1'),
                EasyStep(icon: Icon(Icons.add), title: '2'),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('2'));
      await tester.pump();
      expect(tappedIndex, null);
    });

    testWidgets('renders with reachedSteps', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 0,
              reachedSteps: {1},
              showLoadingAnimation: false,
              steps: [
                EasyStep(icon: Icon(Icons.add), title: '1'),
                EasyStep(icon: Icon(Icons.add), title: '2'),
              ],
            ),
          ),
        ),
      );
      expect(find.byType(EasyStepper), findsOneWidget);
    });

    testWidgets('renders with maxReachedStep', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 0,
              maxReachedStep: 1,
              showLoadingAnimation: false,
              steps: [
                EasyStep(icon: Icon(Icons.add), title: '1'),
                EasyStep(icon: Icon(Icons.add), title: '2'),
              ],
            ),
          ),
        ),
      );
      expect(find.byType(EasyStepper), findsOneWidget);
    });

    testWidgets('respects custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 1,
              activeStepBackgroundColor: Colors.red,
              finishedStepBackgroundColor: Colors.green,
              unreachedStepBackgroundColor: Colors.blue,
              showLoadingAnimation: false,
              steps: [
                EasyStep(icon: Icon(Icons.add), title: '1'),
                EasyStep(icon: Icon(Icons.add), title: '2'),
                EasyStep(icon: Icon(Icons.add), title: '3'),
              ],
            ),
          ),
        ),
      );
      expect(find.byType(EasyStepper), findsOneWidget);
    });

    testWidgets('handles padding and title layout logic',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 0,
              direction: Axis.horizontal,
              titlesAreLargerThanSteps: true,
              padding: EdgeInsets.all(20),
              showLoadingAnimation: false,
              steps: [
                EasyStep(
                  icon: Icon(Icons.add),
                  title: 'Long Title Here',
                  placeTitleAtStart: true,
                ),
                EasyStep(icon: Icon(Icons.add), title: '2'),
              ],
            ),
          ),
        ),
      );
      expect(find.text('Long Title Here'), findsOneWidget);
    });

    testWidgets(
        'throws assertion error when both reachedSteps and maxReachedStep are provided',
        (WidgetTester tester) async {
      expect(
        () => EasyStepper(
          activeStep: 0,
          steps: const [EasyStep(icon: Icon(Icons.add))],
          reachedSteps: const {0},
          maxReachedStep: 0,
        ),
        throwsAssertionError,
      );
    });

    testWidgets('respects disableScroll property', (WidgetTester tester) async {
      // Default: disableScroll = false -> Should have SingleChildScrollView
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 0,
              steps: [EasyStep(icon: Icon(Icons.add))],
              showLoadingAnimation: false,
            ),
          ),
        ),
      );
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // disableScroll = true -> Should NOT have SingleChildScrollView
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyStepper(
              activeStep: 0,
              disableScroll: true,
              steps: [EasyStep(icon: Icon(Icons.add))],
              showLoadingAnimation: false,
            ),
          ),
        ),
      );
      expect(find.byType(SingleChildScrollView), findsNothing);
    });
  });

  group('Flexible Line', () {
    testWidgets('EasyStepper horizontal alignment check',
        (WidgetTester tester) async {
      const double radius = 20.0;
      const double thickness = 3.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: EasyStepper(
                activeStep: 0,
                stepRadius: radius,
                lineStyle: LineStyle(
                  lineLength: double.infinity,
                  lineType: LineType.normal,
                  lineThickness: thickness,
                ),
                steps: [
                  EasyStep(
                    icon: Icon(Icons.check),
                    title: 'Step 1',
                  ),
                  EasyStep(
                    icon: Icon(Icons.check),
                    title: 'Step 2',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Find the widgets
      final stepBuilderFinder = find.byType(StepBuilder).first;
      final easyLineFinder = find.byType(EasyLine).first;

      // Get positions
      final stepTop = tester.getTopLeft(stepBuilderFinder).dy;
      final lineTop = tester.getTopLeft(easyLineFinder).dy;

      // Expected: Line Top = StepTop + Radius - Thickness/2.
      final expectedLineTop = stepTop + radius - (thickness / 2);

      expect(lineTop, closeTo(expectedLineTop, 0.5),
          reason: 'Line should be aligned with the center of the step icon. '
              'StepTop: $stepTop, LineTop: $lineTop, Expected: $expectedLineTop');
    });

    testWidgets('EasyStepper vertical with flexible line length',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: EasyStepper(
                    activeStep: 0,
                    direction: Axis.vertical,
                    lineStyle: LineStyle(
                      lineLength: double.infinity,
                      lineType: LineType.dotted,
                      lineThickness: 2,
                    ),
                    steps: [
                      EasyStep(
                        icon: Icon(Icons.check),
                        title: 'Step 1',
                      ),
                      EasyStep(
                        icon: Icon(Icons.check),
                        title: 'Step 2',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Verify compliance - no overflow
      expect(tester.takeException(), isNull);

      // Verify existence of EasyLine
      final easyLineFinder = find.byType(EasyLine);
      expect(easyLineFinder, findsOneWidget);

      // Verify EasyLine has non-zero width (fixes invisible dotted line)
      final Size lineSize = tester.getSize(easyLineFinder);
      expect(lineSize.width, greaterThan(0),
          reason: 'Vertical dotted line should have non-zero width');

      // Also check height!
      expect(lineSize.height, greaterThan(10),
          reason:
              'Vertical dotted line should have significant height to be visible');

      expect(lineSize.width, greaterThanOrEqualTo(4),
          reason:
              'Vertical dotted line width should be at least double thickness (2*2)');
    });
  });

  group('EasyBorder', () {
    testWidgets('renders with different shapes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                EasyBorder(
                    borderShape: BorderShape.Circle,
                    child: const Text('Circle')),
                EasyBorder(
                    borderShape: BorderShape.Rect, child: const Text('Rect')),
                EasyBorder(
                    borderShape: BorderShape.RRect, child: const Text('RRect')),
                EasyBorder(
                    borderShape: BorderShape.Oval, child: const Text('Oval')),
              ],
            ),
          ),
        ),
      );
      expect(find.text('Circle'), findsOneWidget);
      expect(find.text('Rect'), findsOneWidget);
    });

    testWidgets('validates dash pattern', (WidgetTester tester) async {
      expect(() => EasyBorder(dashPattern: const [], child: const SizedBox()),
          throwsAssertionError);
    });
  });

  group('EasyLine', () {
    testWidgets('renders normal line', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyLine(
              lineType: LineType.normal,
              borderRadius: null,
            ),
          ),
        ),
      );
      expect(find.byType(EasyLine), findsOneWidget);
    });

    testWidgets('renders dotted line', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyLine(
              lineType: LineType.dotted,
              borderRadius: null,
            ),
          ),
        ),
      );
      expect(find.byType(EasyLine), findsOneWidget);
    });

    testWidgets('renders dashed line', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EasyLine(
              lineType: LineType.dashed,
              borderRadius: null,
            ),
          ),
        ),
      );
      expect(find.byType(EasyLine), findsOneWidget);
    });
  });
}
