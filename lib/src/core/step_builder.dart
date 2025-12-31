import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class StepBuilder extends StatelessWidget {
  const StepBuilder({
    Key? key,
    required this.index,
    required this.step,
    required this.activeStep,
    required this.reachedSteps,
    required this.maxReachedStep,
    required this.activeStepBackgroundColor,
    required this.activeStepBorderColor,
    required this.activeStepTextColor,
    required this.activeStepIconColor,
    required this.activeStepBoxShadow,
    required this.finishedStepBackgroundColor,
    required this.finishedStepBorderColor,
    required this.finishedStepTextColor,
    required this.finishedStepIconColor,
    required this.finishedStepBoxShadow,
    required this.unreachedStepBackgroundColor,
    required this.unreachedStepBorderColor,
    required this.unreachedStepTextColor,
    required this.unreachedStepIconColor,
    required this.unreachedStepBoxShadow,
    required this.stepRadius,
    required this.showScrollbar,
    required this.showTitle,
    required this.borderThickness,
    required this.loadingAnimation,
    required this.padding,
    required this.stepShape,
    required this.stepBorderRadius,
    required this.defaultStepBorderType,
    required this.activeStepBorderType,
    required this.unreachedStepBorderType,
    required this.finishedStepBorderType,
    required this.dashPattern,
    required this.showStepBorder,
    required this.showLoadingAnimation,
    required this.textDirection,
    required this.lineLength,
    required this.enabled,
    required this.direction,
    required this.maxTitleLines,
    required this.titleTextStyle,
    required this.enableStepTapping,
    required this.steppingEnabled,
    required this.selectedIndex,
    required this.onStepReached,
    required this.onStepSelected,
  }) : super(key: key);

  final int index;
  final EasyStep step;
  final int activeStep;
  final Set<int>? reachedSteps;
  final int? maxReachedStep;
  final Color? activeStepBackgroundColor;
  final Color? activeStepBorderColor;
  final Color? activeStepTextColor;
  final Color? activeStepIconColor;
  final List<BoxShadow>? activeStepBoxShadow;
  final Color? finishedStepBackgroundColor;
  final Color? finishedStepBorderColor;
  final Color? finishedStepTextColor;
  final Color? finishedStepIconColor;
  final List<BoxShadow>? finishedStepBoxShadow;
  final Color? unreachedStepBackgroundColor;
  final Color? unreachedStepBorderColor;
  final Color? unreachedStepTextColor;
  final Color? unreachedStepIconColor;
  final List<BoxShadow>? unreachedStepBoxShadow;
  final double stepRadius;
  final bool showScrollbar;
  final bool showTitle;
  final double borderThickness;
  final String? loadingAnimation;
  final double padding;
  final StepShape stepShape;
  final double? stepBorderRadius;
  final BorderType defaultStepBorderType;
  final BorderType? activeStepBorderType;
  final BorderType? unreachedStepBorderType;
  final BorderType? finishedStepBorderType;
  final List<double> dashPattern;
  final bool showStepBorder;
  final bool showLoadingAnimation;
  final TextDirection? textDirection;
  final double lineLength;
  final bool enabled;
  final Axis direction;
  final int maxTitleLines;
  final TextStyle? titleTextStyle;
  final bool enableStepTapping;
  final bool steppingEnabled;
  final int selectedIndex;
  final OnStepReached? onStepReached;
  final VoidCallback? onStepSelected;

  @override
  Widget build(BuildContext context) {
    return BaseStep(
      step: step,
      radius: stepRadius,
      showScrollBar: showScrollbar,
      showTitle: showTitle,
      borderThickness: borderThickness,
      isActive: index == activeStep,
      isFinished: _isFinished,
      isUnreached: index > activeStep,
      isAlreadyReached: _isAlreadyReached,
      activeStepBackgroundColor: activeStepBackgroundColor,
      activeStepBorderColor: activeStepBorderColor,
      activeTextColor: activeStepTextColor,
      activeIconColor: activeStepIconColor,
      activeStepBoxShadow: activeStepBoxShadow,
      finishedBackgroundColor: finishedStepBackgroundColor,
      finishedBorderColor: finishedStepBorderColor,
      finishedTextColor: finishedStepTextColor,
      finishedIconColor: finishedStepIconColor,
      finishedStepBoxShadow: finishedStepBoxShadow,
      unreachedBackgroundColor: unreachedStepBackgroundColor,
      unreachedBorderColor: unreachedStepBorderColor,
      unreachedTextColor: unreachedStepTextColor,
      unreachedIconColor: unreachedStepIconColor,
      unreachedStepBoxShadow: unreachedStepBoxShadow,
      lottieAnimation: loadingAnimation,
      padding: padding,
      stepShape: stepShape,
      stepRadius: stepBorderRadius,
      borderType: _handleBorderType,
      dashPattern: dashPattern,
      showStepBorder: showStepBorder,
      showLoadingAnimation: showLoadingAnimation,
      textDirection: textDirection,
      lineLength: lineLength,
      enabled: enabled,
      direction: direction,
      maxTitleLines: maxTitleLines,
      titleTextStyle: titleTextStyle,
      onStepSelected: enableStepTapping ? onStepSelected : null,
    );
  }

  bool get _isFinished {
    if (reachedSteps != null) {
      return index < activeStep && reachedSteps!.contains(index);
    } else {
      return index < activeStep;
    }
  }

  bool get _isAlreadyReached {
    if (reachedSteps != null) {
      return reachedSteps!.contains(index);
    } else {
      return maxReachedStep != null && index <= maxReachedStep!;
    }
  }

  BorderType get _handleBorderType {
    if (index == activeStep) {
      //Active Step
      return activeStepBorderType ?? defaultStepBorderType;
    } else if (index > activeStep) {
      //Unreached Step
      return unreachedStepBorderType ?? defaultStepBorderType;
    } else if (index < activeStep) {
      //Finished Step
      return finishedStepBorderType ?? defaultStepBorderType;
    } else {
      return defaultStepBorderType;
    }
  }
}
