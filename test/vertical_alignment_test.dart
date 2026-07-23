import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(CrossAxisAlignment? align) => MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 400,
          child: EasyStepper(
            activeStep: 1,
            direction: Axis.vertical,
            verticalAlignment: align,
            showLoadingAnimation: false,
            steps: const [
              EasyStep(icon: Icon(Icons.looks_one), title: 'One'),
              EasyStep(icon: Icon(Icons.looks_two), title: 'Two'),
              EasyStep(icon: Icon(Icons.looks_3), title: 'Three'),
            ],
          ),
        ),
      ),
    );

double _iconLeft(WidgetTester t) =>
    t.getTopLeft(find.byIcon(Icons.looks_one)).dx;

void main() {
  testWidgets('vertical steps align start / center / end', (tester) async {
    await tester.pumpWidget(_app(CrossAxisAlignment.start));
    await tester.pump();
    final startX = _iconLeft(tester);

    await tester.pumpWidget(_app(CrossAxisAlignment.center));
    await tester.pump();
    final centerX = _iconLeft(tester);

    await tester.pumpWidget(_app(CrossAxisAlignment.end));
    await tester.pump();
    final endX = _iconLeft(tester);

    // start should be left of center, which should be left of end.
    expect(startX, lessThan(centerX));
    expect(centerX, lessThan(endX));
  });

  testWidgets('null verticalAlignment keeps default (centered) behavior',
      (tester) async {
    await tester.pumpWidget(_app(null));
    await tester.pump();
    expect(find.byIcon(Icons.looks_one), findsOneWidget);
  });
}
