import 'package:easy_stepper/easy_stepper.dart';
import 'package:easy_stepper/src/core/easy_border.dart';
import 'package:lottie/lottie.dart';

/// Callback is fired when a step is reached.
typedef OnStepReached = void Function(int index);

class BaseStep extends StatelessWidget {
  const BaseStep({
    Key? key,
    required this.step,
    required this.isActive,
    required this.isFinished,
    required this.onStepSelected,
    required this.showTitle,
    this.radius = 30,
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
    this.borderThickness,
  }) : super(key: key);
  final EasyStep step;
  final bool isActive;
  final bool isFinished;
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
  final double? borderThickness;
  final String? lottieAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: showTitle ? radius * 2.5 : radius * 2,
      height: showTitle ? radius * 3.5 : radius * 2,
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onStepSelected,
              canRequestFocus: false,
              radius: radius,
              child: Container(
                width: radius * 2,
                height: radius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isFinished
                      ? finishedBackgroundColor ??
                          Theme.of(context).colorScheme.primary
                      : isActive
                          ? activeStepBackgroundColor ??
                              Theme.of(context).colorScheme.secondary
                          : unreachedBackgroundColor ?? Colors.transparent,
                ),
                alignment: Alignment.center,
                child: EasyBorder(
                  borderType: BorderType.Circle,
                  color: isActive
                      ? activeStepBorderColor ??
                          Theme.of(context).scaffoldBackgroundColor
                      : isFinished
                          ? finishedBorderColor ?? Colors.transparent
                          : unreachedBorderColor ?? Colors.grey.shade400,
                  strokeWidth: borderThickness ?? 0.8,
                  child: isActive && step.activeIcon == null
                      ? Center(
                          child: Lottie.asset(
                            lottieAnimation ??
                                (activeStepBackgroundColor != null &&
                                            activeStepBackgroundColor!
                                                    .computeLuminance() >
                                                0.35 ||
                                        activeStepBackgroundColor ==
                                            Colors.transparent
                                    ? "packages/easy_stepper/assets/loading_black.json"
                                    : "packages/easy_stepper/assets/loading_white.json"),
                            width: radius * 1.6,
                            height: radius * 1.6,
                            fit: BoxFit.contain,
                          ),
                        )
                      : SizedBox(
                          width: radius * 2,
                          height: radius * 2,
                          child: Center(
                            child: Icon(
                              isActive && step.activeIcon != null
                                  ? step.activeIcon!.icon
                                  : isFinished && step.finishIcon != null
                                      ? step.finishIcon!.icon
                                      : step.icon.icon,
                              size: radius * 1.1,
                              color: isFinished
                                  ? finishedIconColor ?? Colors.white
                                  : isActive
                                      ? activeIconColor ?? Colors.white
                                      : unreachedIconColor ??
                                          Colors.grey.shade400,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          if (showTitle) const SizedBox(height: 10),
          if (showTitle)
            SizedBox(
              width: radius * 2.5,
              child: Text(
                step.title ?? '',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: isActive
                          ? activeTextColor ??
                              Theme.of(context).colorScheme.secondary
                          : isFinished
                              ? finishedTextColor ??
                                  Theme.of(context).colorScheme.primary
                              : unreachedTextColor ?? Colors.grey.shade400,
                      height: 1,
                      fontSize: radius * 0.55,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
