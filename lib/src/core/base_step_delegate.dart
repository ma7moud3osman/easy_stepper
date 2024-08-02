import 'package:flutter/material.dart';

enum BaseStepElem { step, title }

class BaseStepDelegate extends MultiChildLayoutDelegate {
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
      BoxConstraints.loose(
          size), // This just says that the child cannot be bigger than the whole layout.
    );

    positionChild(
        BaseStepElem.step,
        Offset(
            (size.width - 2 * stepRadius) / 2,
            direction == Axis.horizontal
                ? 0
                : (size.height - 2 * stepRadius) / 2));

    if (hasChild(BaseStepElem.title)) {
      final Size titleSize = layoutChild(
        BaseStepElem.title,
        const BoxConstraints(),
      );

      Offset titleOffset = Offset(-titleSize.width / 2 + (size.width / 2),
          topTitle ? -(stepRadius + titleSize.height) : (stepRadius * 2.35));

      positionChild(BaseStepElem.title, titleOffset);
    }
  }

  @override
  bool shouldRelayout(BaseStepDelegate oldDelegate) {
    return false;
  }
}
