import 'package:flutter/material.dart';

export 'package:easy_stepper/src/core/base_step.dart';
export 'package:easy_stepper/src/core/easy_line.dart';
export 'package:easy_stepper/src/easy_step.dart';
export 'package:flutter/material.dart';

class EasyStep {
  /// The icon displayed in the step, you can change size & color for different status from main stepper.
  final Widget icon;

  /// The icon displayed in the step, when this step is finished. if null the main icon remain displayed.
  final Widget? finishIcon;

  /// The icon displayed in the step, when this step is active. if null the default loading widget displayed.
  final Widget? activeIcon;

  /// The title of the step.
  final Widget? title;

  /// The text appear under the step line, Hence: last step does not have a line
  final String? lineText;

  /// Create a new Step with custom icon and optional title
  const EasyStep({
    required this.icon,
    this.finishIcon,
    this.activeIcon,
    this.title,
    this.lineText,
  });
}
