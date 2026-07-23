import 'dart:math';

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
    this.verticalAlignment = CrossAxisAlignment.center,
  });
  final double stepRadius;
  final Axis direction;
  final bool placeTitleAtStart;
  final TextDirection textDirection;
  final VerticalTitlePlacement verticalTitlePlacement;

  /// Horizontal placement of the step icon within the vertical stepper's width.
  final CrossAxisAlignment verticalAlignment;

  /// Leading x-offset of the step icon for the current [verticalAlignment].
  double _stepDx(double free, bool isRtl) {
    switch (verticalAlignment) {
      case CrossAxisAlignment.start:
        return isRtl ? free : 0;
      case CrossAxisAlignment.end:
        return isRtl ? 0 : free;
      default:
        return free / 2;
    }
  }

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

      if (direction == Axis.horizontal) {
        // Horizontal stepper: keep the existing behavior (step at the top,
        // title either above or below depending on `placeTitleAtStart`).
        final stepOffset = Offset((size.width - stepSize.width) / 2, 0);
        positionChild(BaseStepElem.step, stepOffset);

        final titleX =
            stepOffset.dx + (stepSize.width / 2) - (titleSize.width / 2);
        final titleY = placeTitleAtStart
            ? stepOffset.dy - titleSize.height - titleGap
            : stepOffset.dy + stepSize.height + titleGap;
        positionChild(BaseStepElem.title, Offset(titleX, titleY));
      } else if (verticalTitlePlacement == VerticalTitlePlacement.belowIcon) {
        // Vertical stepper with title below the icon:
        // `BaseStep` reserves extra height using an estimated title height.
        // Center the actual content block (title + gap + step) within that
        // reserved height so the connector line doesn't appear too far below
        // the title.
        final contentHeight = stepSize.height + titleGap + titleSize.height;
        final contentTop = (size.height - contentHeight) / 2;
        final isRtl = textDirection == TextDirection.rtl;

        final stepOffset = Offset(
          _stepDx(size.width - stepSize.width, isRtl),
          contentTop + (placeTitleAtStart ? titleSize.height + titleGap : 0),
        );
        positionChild(BaseStepElem.step, stepOffset);

        // Keep the title centered under the icon, clamped inside the bounds.
        final rawTitleX =
            stepOffset.dx + (stepSize.width / 2) - (titleSize.width / 2);
        final titleX = rawTitleX
            .clamp(
              0.0,
              max(0.0, size.width - titleSize.width),
            )
            .toDouble();
        final titleY = placeTitleAtStart
            ? contentTop
            : stepOffset.dy + stepSize.height + titleGap;
        positionChild(BaseStepElem.title, Offset(titleX, titleY));
      } else {
        // Vertical stepper with side title: align the step icon
        // (start / center / end) and place the title on the inner side so it
        // stays within bounds.
        final isRtl = textDirection == TextDirection.rtl;
        final stepOffset = Offset(
          _stepDx(size.width - stepSize.width, isRtl),
          (size.height - stepSize.height) / 2,
        );

        positionChild(BaseStepElem.step, stepOffset);

        // Does the title sit after the icon in reading order?
        late final bool titleAfterIcon;
        if (verticalAlignment == CrossAxisAlignment.start) {
          titleAfterIcon = true; // icon at leading edge → title trailing
        } else if (verticalAlignment == CrossAxisAlignment.end) {
          titleAfterIcon = false; // icon at trailing edge → title leading
        } else {
          titleAfterIcon = !placeTitleAtStart;
        }

        final trailingX = stepOffset.dx + stepSize.width + 12;
        final leadingX = stepOffset.dx - titleSize.width - 12;
        final titleX = (titleAfterIcon ^ isRtl) ? trailingX : leadingX;

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
        verticalTitlePlacement != oldDelegate.verticalTitlePlacement ||
        verticalAlignment != oldDelegate.verticalAlignment;
  }
}
