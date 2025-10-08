import 'dart:math';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:easy_stepper/src/core/easy_border.dart';
import 'package:easy_stepper/src/utils/platform_stub.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'base_step_delegate.dart';

/// Callback is fired when a step is reached.
typedef OnStepReached = void Function(int index);

enum StepShape { circle, rRectangle }

enum BorderType { normal, dotted }

class BaseStep extends StatelessWidget {
  const BaseStep({
    Key? key,
    required this.step,
    required this.isActive,
    required this.isFinished,
    required this.isUnreached,
    required this.isAlreadyReached,
    required this.onStepSelected,
    required this.showTitle,
    required this.radius,
    required this.activeStepBackgroundColor,
    required this.finishedBackgroundColor,
    required this.unreachedBackgroundColor,
    required this.unreachedStepBoxShadow,
    required this.activeStepBoxShadow,
    required this.finishedStepBoxShadow,
    required this.activeStepBorderColor,
    required this.finishedBorderColor,
    required this.unreachedBorderColor,
    required this.activeTextColor,
    required this.activeIconColor,
    required this.finishedTextColor,
    required this.unreachedTextColor,
    required this.unreachedIconColor,
    required this.finishedIconColor,
    required this.lottieAnimation,
    required this.padding,
    required this.stepShape,
    required this.stepRadius,
    required this.borderThickness,
    required this.borderType,
    required this.dashPattern,
    required this.showStepBorder,
    required this.showLoadingAnimation,
    required this.textDirection,
    required this.lineLength,
    required this.enabled,
    required this.direction,
    required this.showScrollBar,
    required this.maxTitleLines,
    required this.titleTextStyle,
  }) : super(key: key);
  final EasyStep step;
  final bool isActive;
  final bool isFinished;
  final bool isUnreached;
  final bool isAlreadyReached;
  final VoidCallback? onStepSelected;
  final double radius;
  final bool showTitle;
  final Color? activeStepBackgroundColor;
  final Color? unreachedBackgroundColor;
  final Color? finishedBackgroundColor;
  final List<BoxShadow>? activeStepBoxShadow;
  final List<BoxShadow>? unreachedStepBoxShadow;
  final List<BoxShadow>? finishedStepBoxShadow;
  final Color? activeStepBorderColor;
  final Color? unreachedBorderColor;
  final Color? finishedBorderColor;
  final Color? activeTextColor;
  final Color? activeIconColor;
  final Color? unreachedTextColor;
  final Color? unreachedIconColor;
  final Color? finishedTextColor;
  final Color? finishedIconColor;
  final double borderThickness;
  final String? lottieAnimation;
  final double? padding;
  final StepShape stepShape;
  final double? stepRadius;
  final BorderType borderType;
  final List<double> dashPattern;
  final bool showStepBorder;
  final bool showLoadingAnimation;
  final TextDirection? textDirection;
  final double lineLength;
  final bool enabled;
  final bool showScrollBar;
  final Axis direction;
  final int maxTitleLines;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    final textHight = max(1, maxTitleLines) * 20 + 15;
    return SizedBox(
      width: direction == Axis.vertical ? null : (radius * 2) + (padding ?? 0),
      height: showScrollBar
          ? 20 + (showTitle ? radius * 2 + textHight : radius * 2)
          : (showTitle ? radius * 2 + textHight : radius * 2),
      child: CustomMultiChildLayout(
        delegate: BaseStepDelegate(
          stepRadius: radius,
          placeTitleAtStart: step.placeTitleAtStart || step.topTitle,
          direction: direction,
          textDirection: textDirection ?? Directionality.of(context),
        ),
        children: [
          LayoutId(
            id: BaseStepElem.step,
            child: Container(
              decoration: BoxDecoration(
                shape: stepShape == StepShape.circle
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                boxShadow: _handleBoxShadow(
                    context, isFinished, isActive, isAlreadyReached),
                borderRadius: stepShape != StepShape.circle
                    ? BorderRadius.circular(stepRadius ?? 0)
                    : null,
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: enabled ? onStepSelected : null,
                canRequestFocus: false,
                radius: radius * 4,
                borderRadius: BorderRadius.circular(stepRadius ?? 0),
                child: Container(
                  width: radius * 2,
                  height: radius * 2,
                  decoration: BoxDecoration(
                    shape: stepShape == StepShape.circle
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    borderRadius: stepShape != StepShape.circle
                        ? BorderRadius.circular(stepRadius ?? 0)
                        : null,
                    color: _handleColor(
                      context,
                      isFinished,
                      isActive,
                      isAlreadyReached,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: showStepBorder
                      ? EasyBorder(
                          borderShape: stepShape == StepShape.circle
                              ? BorderShape.Circle
                              : BorderShape.RRect,
                          radius: stepShape != StepShape.circle
                              ? Radius.circular(stepRadius ?? 0)
                              : const Radius.circular(0),
                          color: _handleBorderColor(
                              context, isFinished, isActive, isAlreadyReached),
                          strokeWidth: borderThickness,
                          dashPattern: borderType == BorderType.normal
                              ? [1, 0]
                              : dashPattern,
                          child: isActive && showLoadingAnimation
                              ? _buildLoadingIcon()
                              : _buildIcon(context),
                        )
                      : isActive && showLoadingAnimation
                          ? _buildLoadingIcon()
                          : _buildIcon(context),
                ),
              ),
            ),
          ),
          if (showTitle)
            LayoutId(
              id: BaseStepElem.title,
              child: _buildStepTitle(context),
            )
        ],
      ),
    );
  }

  Color _handleColor(BuildContext context, bool isFinished, bool isActive,
      bool isAlreadyReached) {
    if (isActive) {
      return activeStepBackgroundColor ?? Colors.transparent;
    } else {
      if (isFinished) {
        return finishedBackgroundColor ?? Theme.of(context).colorScheme.primary;
      } else if (isAlreadyReached) {
        return finishedBackgroundColor ?? Theme.of(context).colorScheme.primary;
      } else {
        return unreachedBackgroundColor ?? Colors.transparent;
      }
    }
  }

  Color _handleBorderColor(BuildContext context, bool isFinished, bool isActive,
      bool isAlreadyReached) {
    if (isActive) {
      return activeStepBorderColor ?? Theme.of(context).colorScheme.primary;
    } else {
      if (isFinished) {
        return finishedBorderColor ?? Colors.transparent;
      } else if (isAlreadyReached) {
        return finishedBorderColor ?? Colors.transparent;
      } else {
        return unreachedBorderColor ?? Colors.grey.shade400;
      }
    }
  }

  List<BoxShadow>? _handleBoxShadow(BuildContext context, bool isFinished,
      bool isActive, bool isAlreadyReached) {
    if (isActive) {
      return activeStepBoxShadow;
    } else {
      if (isFinished) {
        return finishedStepBoxShadow;
      } else if (isAlreadyReached) {
        return finishedStepBoxShadow;
      } else {
        return unreachedStepBoxShadow;
      }
    }
  }

  Color _handleTitleColor(
    BuildContext context,
    bool isFinished,
    bool isActive,
    bool isAlreadyReached,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    if (isActive) {
      return activeTextColor ?? colorScheme.primary;
    } else {
      if (isFinished) {
        return finishedTextColor ?? colorScheme.onSurface;
      } else if (isAlreadyReached) {
        return finishedTextColor ?? colorScheme.onSurface;
      } else {
        return unreachedTextColor ?? Colors.grey.shade400;
      }
    }
  }

  Color _handleIconColor(
    BuildContext context,
    bool isFinished,
    bool isActive,
    bool isAlreadyReached,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    if (isActive) {
      return activeIconColor ?? colorScheme.primary;
    } else {
      if (isFinished) {
        return finishedIconColor ?? colorScheme.onPrimary;
      } else if (isAlreadyReached) {
        return finishedIconColor ?? colorScheme.onPrimary;
      } else {
        return unreachedIconColor ?? Colors.grey.shade400;
      }
    }
  }

  Widget _buildStepTitle(BuildContext context) {
    return SizedBox(
      width: direction == Axis.vertical
          ? null
          : (radius * 2) + (padding ?? 0) + (lineLength),
      child: Align(
        alignment: AlignmentDirectional.center,
        child: step.customTitle ??
            Text(
              step.title ?? '',
              maxLines: max(1, maxTitleLines),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle ??
                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: _handleTitleColor(
                          context,
                          isFinished,
                          isActive,
                          isAlreadyReached,
                        ),
                      ),
            ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return step.customStep ??
        SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: Center(
            child: Icon(
              isActive && step.activeIcon != null
                  ? step.activeIcon!.icon
                  : isFinished && step.finishIcon != null
                      ? step.finishIcon!.icon
                      : step.icon!.icon,
              size: radius * 0.9,
              color: _handleIconColor(
                  context, isFinished, isActive, isAlreadyReached),
            ),
          ),
        );
  }

  Center _buildLoadingIcon() {
    return Center(
      child: Lottie.asset(
        lottieAnimation ??
            (((activeStepBackgroundColor != null &&
                        activeStepBackgroundColor!.computeLuminance() < 0.35) &&
                    activeStepBackgroundColor != Colors.transparent)
                ? "packages/easy_stepper/assets/loading_white.json"
                : "packages/easy_stepper/assets/loading_black.json"),
        animate: !isWeb,
        width: radius * 1.6,
        height: radius * 1.6,
        fit: BoxFit.contain,
      ),
    );
  }
}
