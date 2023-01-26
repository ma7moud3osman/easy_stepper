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
  }) : super(key: key);
  final EasyStep step;
  final bool isActive;
  final bool isFinished;
  final bool isUnreached;
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (radius * 2) + (padding ?? 0),
      height: showTitle ? radius * 3.5 : radius * 2,
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            shape: stepShape == StepShape.circle ? const CircleBorder() : null,
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
                  color: isFinished
                      ? finishedBackgroundColor ??
                          Theme.of(context).colorScheme.primary
                      : isActive
                          ? activeStepBackgroundColor ?? Colors.transparent
                          : unreachedBackgroundColor ?? Colors.transparent,
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
                        color: isActive
                            ? activeStepBorderColor ??
                                Theme.of(context).colorScheme.primary
                            : isFinished
                                ? finishedBorderColor ?? Colors.transparent
                                : unreachedBorderColor ?? Colors.grey.shade400,
                        strokeWidth: borderThickness,
                        dashPattern: borderType == BorderType.normal
                            ? [1, 0]
                            : dashPattern,
                        child: isActive && step.activeIcon == null
                            ? _buildDefaultActiveIcon()
                            : _buildCustomIcon(context),
                      )
                    : isActive && step.activeIcon == null
                        ? _buildDefaultActiveIcon()
                        : _buildCustomIcon(context),
              ),
            ),
          ),
          if (showTitle) const SizedBox(height: 10),
          if (showTitle)
            SizedBox(
              width: (radius * 2) + (padding ?? 0),
              child: Text(
                step.title ?? '',
                maxLines: 2,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: isActive
                          ? activeTextColor ??
                              Theme.of(context).colorScheme.primary
                          : isFinished
                              ? finishedTextColor ??
                                  Theme.of(context).colorScheme.primary
                              : unreachedTextColor ?? Colors.grey.shade400,
                      height: 1,
                      fontSize: radius * 0.45,
                    ),
              ),
            ),
        ],
      ),
    );
  }

  SizedBox _buildCustomIcon(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Center(
        child: Icon(
          isActive && step.activeIcon != null
              ? step.activeIcon!.icon
              : isFinished && step.finishIcon != null
                  ? step.finishIcon!.icon
                  : step.icon.icon,
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

  Center _buildDefaultActiveIcon() {
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
