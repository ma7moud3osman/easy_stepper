import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EasyStep extends StatelessWidget {
  const EasyStep({
    Key? key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.isFinished,
    this.lottieJson = 'assets/stepper_loading.json',
    this.shiftLeft = false,
    this.activeBackgroundColor,
    this.finishedBackgroundColor,
    this.unreachedBackgroundColor,
    this.activeBorderColor,
    this.finishedBorderColor,
    this.unreachedBorderColor,
    this.activeTextColor,
    this.unreachedTextColor,
    this.finishedTextColor,
    this.radius = 30,
  }) : super(key: key);
  final Widget icon;
  final String title;
  final bool isActive;
  final bool isFinished;
  final bool shiftLeft;
  final String lottieJson;
  final Color? activeBackgroundColor;
  final Color? unreachedBackgroundColor;
  final Color? finishedBackgroundColor;
  final Color? activeBorderColor;
  final Color? unreachedBorderColor;
  final Color? finishedBorderColor;
  final Color? activeTextColor;
  final Color? unreachedTextColor;
  final Color? finishedTextColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          borderRadius: BorderRadius.circular(100),
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFinished
                  ? finishedBackgroundColor ??
                      Theme.of(context).colorScheme.primary
                  : isActive
                      ? activeBackgroundColor ??
                          Theme.of(context).colorScheme.primary
                      : unreachedBackgroundColor ?? Colors.transparent,
            ),
            child: DottedBorder(
              borderType: BorderType.Circle,
              color: isActive
                  ? activeBorderColor ?? Theme.of(context).colorScheme.primary
                  : isFinished
                      ? finishedBorderColor ?? Colors.transparent
                      : unreachedBorderColor ?? const Color(0xffBABABA),
              strokeWidth: 0.8,
              padding: const EdgeInsets.all(10),
              child: isActive
                  ? LottieBuilder.asset(
                      lottieJson,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Center(child: icon),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: isActive
                    ? activeTextColor ?? Theme.of(context).colorScheme.primary
                    : isFinished
                        ? finishedTextColor ?? Colors.black
                        : unreachedTextColor ?? const Color(0xffBABABA),
              ),
        ),
      ],
    );
  }
}
