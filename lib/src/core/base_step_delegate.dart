import 'package:flutter/material.dart';

enum BaseStepElem { step, title }

class BaseStepDelegate extends MultiChildLayoutDelegate {

  BaseStepDelegate({
    required this.stepRadius,
    required this.direction,
    this.placeTitleAtStart = false,
    required this.textDirection,
  });
  final double stepRadius;
  final Axis direction;
  final bool placeTitleAtStart;
  final TextDirection textDirection;

  @override
  void performLayout(Size size) {
    assert(hasChild(BaseStepElem.step));

    final stepSize = layoutChild(
      BaseStepElem.step,
      BoxConstraints.loose(size),
    );

    final stepOffset = Offset(
      (size.width - stepSize.width) / 2,
      direction == Axis.horizontal ? 0 : (size.height - stepSize.height) / 2,
    );

    positionChild(BaseStepElem.step, stepOffset);

    if (hasChild(BaseStepElem.title)) {
      final titleSize = layoutChild(
        BaseStepElem.title,
        const BoxConstraints(),
      );

      Offset titleOffset;

      if (direction == Axis.horizontal) {
        // Horizontal: above or below the step
        final titleX =
            stepOffset.dx + (stepSize.width / 2) - (titleSize.width / 2);
        final titleY = placeTitleAtStart
            ? stepOffset.dy - titleSize.height - 8
            : stepOffset.dy + stepSize.height + 8;
        titleOffset = Offset(titleX, titleY);
      } else {
        // Vertical: at logical END or START depending on topTitle & textDirection
        final isRtl = textDirection == TextDirection.rtl;

        double titleX;
        if (placeTitleAtStart) {
          // At the logical START
          titleX = isRtl
              ? stepOffset.dx + stepSize.width + 12 // right in RTL
              : stepOffset.dx - titleSize.width - 12; // left in LTR
        } else {
          // At the logical END
          titleX = isRtl
              ? stepOffset.dx - titleSize.width - 12 // left in RTL
              : stepOffset.dx + stepSize.width + 12; // right in LTR
        }

        final titleY =
            stepOffset.dy + (stepSize.height / 2) - (titleSize.height / 2);
        titleOffset = Offset(titleX, titleY);
      }

      positionChild(BaseStepElem.title, titleOffset);
    }
  }

  @override
  bool shouldRelayout(BaseStepDelegate oldDelegate) {
    return stepRadius != oldDelegate.stepRadius ||
        direction != oldDelegate.direction ||
        placeTitleAtStart != oldDelegate.placeTitleAtStart ||
        textDirection != oldDelegate.textDirection;
  }
}
