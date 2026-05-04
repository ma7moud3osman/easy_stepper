import 'package:flutter/material.dart';

import 'vertical_title_placement.dart';

enum BaseStepElem { step, title }

class BaseStepDelegate extends MultiChildLayoutDelegate {
  BaseStepDelegate({
    required this.stepRadius,
    required this.direction,
    this.placeTitleAtStart = false,
    required this.textDirection,
    this.verticalTitlePlacement = VerticalTitlePlacement.belowIcon,
  });
  final double stepRadius;
  final Axis direction;
  final bool placeTitleAtStart;
  final TextDirection textDirection;
  final VerticalTitlePlacement verticalTitlePlacement;

  @override
  void performLayout(Size size) {
    assert(hasChild(BaseStepElem.step));

    const titleGap = 8.0;

    final stepSize = layoutChild(
      BaseStepElem.step,
      BoxConstraints.loose(size),
    );

    if (hasChild(BaseStepElem.title)) {
      final titleSize = layoutChild(
        BaseStepElem.title,
        const BoxConstraints(),
      );

      if (direction == Axis.horizontal ||
          verticalTitlePlacement == VerticalTitlePlacement.belowIcon) {
        final stepOffset = Offset(
          (size.width - stepSize.width) / 2,
          direction == Axis.horizontal
              ? 0
              : (placeTitleAtStart ? titleSize.height + titleGap : 0),
        );

        positionChild(BaseStepElem.step, stepOffset);

        final titleX =
            stepOffset.dx + (stepSize.width / 2) - (titleSize.width / 2);
        final titleY = placeTitleAtStart
            ? stepOffset.dy - titleSize.height - titleGap
            : stepOffset.dy + stepSize.height + titleGap;
        positionChild(BaseStepElem.title, Offset(titleX, titleY));
      } else {
        final stepOffset = Offset(
          (size.width - stepSize.width) / 2,
          (size.height - stepSize.height) / 2,
        );

        positionChild(BaseStepElem.step, stepOffset);

        final isRtl = textDirection == TextDirection.rtl;

        double titleX;
        if (placeTitleAtStart) {
          titleX = isRtl
              ? stepOffset.dx + stepSize.width + 12
              : stepOffset.dx - titleSize.width - 12;
        } else {
          titleX = isRtl
              ? stepOffset.dx - titleSize.width - 12
              : stepOffset.dx + stepSize.width + 12;
        }

        final titleY =
            stepOffset.dy + (stepSize.height / 2) - (titleSize.height / 2);
        positionChild(BaseStepElem.title, Offset(titleX, titleY));
      }
    } else {
      final stepOffset = Offset(
        (size.width - stepSize.width) / 2,
        0,
      );
      positionChild(BaseStepElem.step, stepOffset);
    }
  }

  @override
  bool shouldRelayout(BaseStepDelegate oldDelegate) {
    return stepRadius != oldDelegate.stepRadius ||
        direction != oldDelegate.direction ||
        placeTitleAtStart != oldDelegate.placeTitleAtStart ||
        textDirection != oldDelegate.textDirection ||
        verticalTitlePlacement != oldDelegate.verticalTitlePlacement;
  }
}
