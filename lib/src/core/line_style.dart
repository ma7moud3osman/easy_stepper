import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class LineStyle {
  /// The color of the line that separates the steps.
  /// If null, [Theme.of(context).colorScheme.primary] will be used.
  final Color? defaultLineColor;

  /// The color of the line that branches out from unreached steps.
  final Color? unreachedLineColor;

  /// The color of the line that branches out from active step.
  final Color? activeLineColor;

  /// The color of the line that branches out from finished steps.
  final Color? finishedLineColor;

  /// The length of the line that separates the steps.
  final double lineLength;

  /// The thickness of the line that separates the steps.
  final double lineThickness;

  /// The Width of the dashes in the line.
  final double lineWidth;

  /// The space between individual dot within the line that separates the steps.
  final double lineSpace;

  /// The type of the lines [normal, dotted].
  final LineType lineType;

  /// The type of the unreached lines [normal, dotted].
  /// if null `lineType` will be default for all lines.
  final LineType? unreachedLineType;

  /// The color of the progress part of the active line that branches out from current step.
  final Color? progressColor;

  /// Progress value of the active line. Hence, values range from 0 to 1.
  final double? progress;

  /// The border radius of the line that separates the steps.
  final BorderRadiusGeometry? borderRadius;

  const LineStyle({
    Key? key,
    this.lineType = LineType.dotted,
    this.defaultLineColor,
    this.unreachedLineColor,
    this.activeLineColor,
    this.finishedLineColor,
    this.lineLength = 40,
    this.lineWidth = 4,
    this.lineThickness = 1,
    this.lineSpace = 5,
    this.unreachedLineType,
    this.progressColor,
    this.progress,
    this.borderRadius,
  }) : assert(
          progressColor == null || progress != null,
          'progress should be defined to use progressColor',
        );
}
