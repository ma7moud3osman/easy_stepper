import 'package:easy_stepper/easy_stepper.dart';
import 'package:easy_stepper/src/core/easy_border.dart';
import 'package:lottie/lottie.dart';

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
  final TextDirection textDirection;
  final double lineLength;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (radius * 2) + (padding ?? 0),
      height: showTitle ? radius * 2.5 + 25 : radius * 1.5 + 15,
      child: InkWell(
        onTap: enabled ? onStepSelected : null,
        canRequestFocus: false,
        child: Stack(
          clipBehavior: Clip.none,
          textDirection: textDirection,
          alignment: Alignment.topCenter,
          children: [
            Material(
              color: Colors.transparent,
              shape:
                  stepShape == StepShape.circle ? const CircleBorder() : null,
              clipBehavior: Clip.antiAlias,
              borderRadius: stepShape != StepShape.circle
                  ? BorderRadius.circular(stepRadius ?? 0)
                  : null,
              child: InkWell(
                onTap: onStepSelected,
                canRequestFocus: false,
                radius: radius,
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
                      color: _handleColor(context, isFinished, isActive, isAlreadyReached)
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
                          color: _handleBorderColor(context, isFinished, isActive, isAlreadyReached),
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
            if (showTitle) _buildStepTitle(context),
          ],
        ),
      ),
    );
  }

  Color _handleColor(BuildContext context, bool isFinished, bool isActive, bool isAlreadyReached)  {
    if (isActive) {
      return activeStepBackgroundColor ?? Colors.transparent;
    } else {
      if(isFinished) {
        return finishedBackgroundColor ??
            Theme.of(context).colorScheme.primary;
      } else if(isAlreadyReached) {
        return finishedBackgroundColor ??
            Theme.of(context).colorScheme.primary;
      } else {
        return unreachedBackgroundColor ?? Colors.transparent;
      }
    }
  }

  Color _handleBorderColor(BuildContext context, bool isFinished, bool isActive, bool isAlreadyReached) {
    if (isActive) {
      return activeStepBorderColor ?? Theme.of(context).colorScheme.primary;
    } else {
      if(isFinished) {
        return finishedBorderColor ?? Colors.transparent;
      } else if(isAlreadyReached) {
        return finishedBorderColor ?? Colors.transparent;
      } else {
        return unreachedBorderColor ??
            Colors.grey.shade400;
      }
    }
  }

  Widget _buildStepTitle(BuildContext context) {
    return Positioned.directional(
      textDirection: textDirection,
      top: step.topTitle ? -20 : (radius * 2.35),
      // bottom: radius * 0.3,
      // end: (radius * 1.3) - ((step.title?.length ?? 5) * 4),
      // start: (radius * 1.3) - ((step.title?.length ?? 5) * 4),
      child: SizedBox(
        width: (radius * 2) + (padding ?? 0) + (lineLength / 1.0),
        child: step.customTitle ??
            Text(
              step.title ?? '',
              maxLines: 3,
              textAlign: TextAlign.center,
              softWrap: false,
              overflow: TextOverflow.visible,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: isActive
                        ? activeTextColor ??
                            Theme.of(context).colorScheme.primary
                        : isFinished
                            ? finishedTextColor ??
                                Theme.of(context).colorScheme.primary
                            : unreachedTextColor ?? Colors.grey.shade400,
                    height: 1,
                    // fontSize: radius * 0.45,
                  ),
            ),
      ),
    );
  }

  SizedBox _buildIcon(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Center(
        child: step.customStep ??
            Icon(
              isActive && step.activeIcon != null
                  ? step.activeIcon!.icon
                  : isFinished && step.finishIcon != null
                      ? step.finishIcon!.icon
                      : step.icon!.icon,
              size: radius * 0.9,
              color: isFinished
                  ? finishedIconColor ?? Colors.white
                  : isActive
                      ? activeIconColor ?? Theme.of(context).colorScheme.primary
                      : unreachedIconColor ?? Colors.grey.shade400,
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
        width: radius * 1.6,
        height: radius * 1.6,
        fit: BoxFit.contain,
      ),
    );
  }
}
