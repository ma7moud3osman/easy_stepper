import 'package:flutter/material.dart';

enum BaseStepElem{
  step,
  title
}

class BaseStepDelegate extends MultiChildLayoutDelegate{
  final double stepRadius;
  final Axis direction;
  final bool topTitle;

  BaseStepDelegate({
    required this.stepRadius,
    required this.direction,
    this.topTitle = false,
  });

  @override
  void performLayout(Size size) {
    assert(hasChild(BaseStepElem.step));

    layoutChild(
      BaseStepElem.step,
      BoxConstraints.loose(size), // This just says that the child cannot be bigger than the whole layout.
    );

    positionChild(
        BaseStepElem.step,
        Offset((size.width - 2 * stepRadius) / 2, direction == Axis.horizontal ? 0 : (size.height - 2 * stepRadius) / 2)
    );

    if (hasChild(BaseStepElem.title)) {
      final Size titleSize = layoutChild(
        BaseStepElem.title,
        const BoxConstraints(),
      );

      if (direction == Axis.horizontal) {
        Offset titleOffset = Offset(-titleSize.width / 2 + (size.width / 2),
            topTitle ? -(stepRadius + titleSize.height) : (stepRadius * 2.35));

        positionChild(BaseStepElem.title, titleOffset);
      } else {
        // Space evenly Step and Title
        double stepY;
        double titleY;

        double spaceY = (size.height - stepRadius * 2 - titleSize.height) / 3;

        if (topTitle) {
          titleY = spaceY;
          stepY = 2 * spaceY + titleSize.height;
        } else {
          stepY = spaceY;
          titleY = 2 * (spaceY + stepRadius);
        }

        positionChild(
          BaseStepElem.step,
          Offset((size.width - 2 * stepRadius) / 2,
              direction == Axis.horizontal ? 0 : stepY),
        );

        Offset titleOffset =
            Offset(-titleSize.width / 2 + (size.width / 2), titleY);

        positionChild(BaseStepElem.title, titleOffset);
      }
    } else {
      // Position step in the middle
      positionChild(
          BaseStepElem.step,
          Offset(
              (size.width - 2 * stepRadius) / 2,
              direction == Axis.horizontal
                  ? 0
                  : (size.height - 2 * stepRadius) / 2));
    }
  }

  @override
  bool shouldRelayout(BaseStepDelegate oldDelegate) {
    return false;
  }
}