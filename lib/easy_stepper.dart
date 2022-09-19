library easy_stepper;

import 'package:easy_stepper/src/step.dart';
import 'package:easy_stepper/src/step_line.dart';
import 'package:flutter/material.dart';

class EasyStepper extends StatelessWidget {
  final List<EasyStep> steps;
  final void Function(int index) onStepSelected;
  final Axis? axis;
  final ScrollPhysics? physics;

  const EasyStepper({
    Key? key,
    required this.steps,
    required this.onStepSelected,
    this.axis,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: axis ?? Axis.horizontal,
      physics: physics,
      itemBuilder: (context, index) {
        final step = steps[index];
        return InkWell(
          onTap: () => onStepSelected(index),
          child: EasyStep(
            icon: step.icon,
            title: step.title,
            isActive: step.isActive,
            isFinished: step.isFinished,
            shiftLeft: step.shiftLeft,
          ),
        );
      },
      separatorBuilder: (_, index) => StepLine(
        isFinished: steps[index].isActive,
        finishedLineColor: steps[index].finishedBorderColor,
        unreachedLineColor: steps[index].unreachedBorderColor,
      ),
      itemCount: steps.length,
    );
  }
}
