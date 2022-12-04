import 'package:flutter/material.dart';

export 'package:easy_stepper/src/core/base_step.dart';
export 'package:easy_stepper/src/core/easy_dotted_line.dart';
export 'package:easy_stepper/src/easy_step.dart';
export 'package:flutter/material.dart';

class EasyStep {
  /// The icon displayed in the step, you can change size & color for different status from main stepper.
  final Icon icon;

  /// The title of the step.
  final String? title;

  /// The text appear under the step line
  final String? lineText;

  /// Create a new Step with custom icon and optional title
  const EasyStep({
    required this.icon,
    this.title,
    this.lineText,
  });
}
