library easy_stepper;

import 'dart:io';
import 'dart:math';

import 'package:easy_stepper/src/core/custom_scroll_behavior.dart';
import 'package:easy_stepper/src/easy_step.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

export 'package:easy_stepper/src/easy_step.dart';

class EasyStepper extends StatefulWidget {
  /// Each Step defines a step icon and title. Hence, total number of icons determines the total number of steps.
  final List<EasyStep> steps;

  /// Whether to allow tapping a step to move to that step or not.
  final bool enableStepTapping;

  /// Determines what should happen when a step is reached. This callback provides the __index__ of the step that was reached.
  final OnStepReached? onStepReached;

  /// Whether to show the steps horizontally or vertically. __Note: Ensure horizontal stepper goes inside a column and vertical goes inside a row.__
  final Axis direction;

  /// The color of the step background when it is not reached.
  final Color? unreachedStepBackgroundColor;

  /// The color of the step text and icon when it is not reached.
  final Color? unreachedStepTextColor;

  /// The color of the step icon when it is not reached.
  final Color? unreachedStepIconColor;

  /// The color of the step border when it is not reached.
  final Color? unreachedStepBorderColor;

  /// The type of the step border  when it is not reached [normal, dotted].
  final BorderType? unreachedStepBorderType;

  /// The color of a step background when it is reached.
  final Color? activeStepBackgroundColor;

  /// The color of a step text and icon when it is reached.
  final Color? activeStepTextColor;

  /// The color of the step icon when it is reached.
  final Color? activeStepIconColor;

  /// The border color of a step when it is reached.
  final Color? activeStepBorderColor;

  /// The type of the step border  when it is reached [normal, dotted].
  final BorderType? activeStepBorderType;

  /// The color of the step background when it is finished.
  final Color? finishedStepBackgroundColor;

  /// The border color of a step when it is finished.
  final Color? finishedStepBorderColor;

  /// The color of the step text and icon when it is finished.
  final Color? finishedStepTextColor;

  /// The color of the step icon when it is finished.
  final Color? finishedStepIconColor;

  /// The type of the step border  when it is finished [normal, dotted].
  final BorderType? finishedStepBorderType;

  /// The color of the line that separates the steps.
  /// If null, [Theme.of(context).colorScheme.primary] will be used.
  final Color? defaultLineColor;

  /// The color of the line that branches out from unreached steps.
  final Color? unreachedLineColor;

  /// The color of the line that branches out from active step.
  final Color? activeLineColor;

  /// The color of the line that branches out from finished steps.
  final Color? finishedLineColor;

  /// The radius of a step.
  final double stepRadius;

  /// Whether the stepping is enabled or disabled.
  final bool steppingEnabled;

  /// Whether the scrolling is disabled or not.
  final bool disableScroll;

  /// The index of currently active step.
  final int activeStep;

  /// The index of highest reached step
  final int? maxReachedStep;

  /// Whether show step title or not.
  final bool showTitle;

  /// Specifies the alignment of IconStepper widget.
  final AlignmentGeometry alignment;

  /// The length of the line that separates the steps.
  final double lineLength;

  /// The radius of individual dot within the line that separates the steps, if `lineType` set to `normal` this property is used to change the
  final double? lineDotRadius;

  /// The thickness of the line that separates the steps.
  final double lineThickness;

  /// The space between individual dot within the line that separates the steps.
  final double lineSpace;

  /// The type of the line [normal, dotted].
  final LineType lineType;

  /// The amount of padding around every step.
  final double internalPadding;

  /// The amount of padding around the stepper.
  final EdgeInsetsDirectional padding;

  /// The animation effect to show when a step is reached.
  final Curve stepReachedAnimationEffect;

  /// The curve of the animation to show when a step is reached.
  final Curve? stepAnimationCurve;

  /// The duration of the animation effect to show when a step is reached.
  final Duration stepReachedAnimationDuration;

  /// The duration of the animation effect to show when a step is reached.
  final Duration? stepAnimationDuration;

  ///The thickness of the step border.
  final double borderThickness;

  ///The shape of the step [Circle, Rectangle, Triangle].
  final StepShape stepShape;

  ///The radius of the step border. Hence, stepBorderRadius ignored if stepShape is Circle.
  final double? stepBorderRadius;

  /// The type of the step border for all states (Unreached, Active & Finished) [normal, dotted].
  final BorderType defaultStepBorderType;

  /// The Pattern of the border dashes when BorderType set to [BorderType.dotted].
  final List<double> dashPattern;

  /// Show or Hide step border.
  final bool showStepBorder;

  ///The loading animation shows when the step is active. Hence, use lottie json files only by adding its path.
  final String? loadingAnimation;

  /// Show or hide the loading animation inside `Step` widget.
  /// Defaults to `True`
  final bool showLoadingAnimation;

  /// Text Direction of the app.
  final TextDirection textDirection;

  /// Show `Scrollbar` in Web or Desktop. default `True`.
  final bool showScrollbar;

  /// Whether the stepper take the full width of the screen or not, this property work when `disableScroll = true`. default `True`.
  final bool fitWidth;

  const EasyStepper({
    Key? key,
    required this.activeStep,
    required this.steps,
    this.maxReachedStep,
    this.lineType = LineType.dotted,
    this.enableStepTapping = true,
    this.direction = Axis.horizontal,
    this.onStepReached,
    this.unreachedStepBackgroundColor,
    this.unreachedStepTextColor,
    this.unreachedStepIconColor,
    this.unreachedStepBorderColor,
    this.activeStepTextColor,
    this.activeStepIconColor,
    this.activeStepBackgroundColor,
    this.activeStepBorderColor,
    this.finishedStepTextColor,
    this.finishedStepBackgroundColor,
    this.finishedStepBorderColor,
    this.finishedStepIconColor,
    this.defaultLineColor,
    this.unreachedLineColor,
    this.activeLineColor,
    this.finishedLineColor,
    this.stepRadius = 30,
    this.steppingEnabled = true,
    this.disableScroll = false,
    this.showTitle = true,
    this.alignment = Alignment.center,
    this.lineLength = 40,
    this.fitWidth = true,
    this.showScrollbar = true,
    @Deprecated(
        "use 'lineThickness' instead, This feature was deprecated after v0.5.1")
    this.lineDotRadius,
    this.lineThickness = 1,
    this.lineSpace = 5,
    this.padding =
        const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
    this.internalPadding = 8,
    @Deprecated(
        "use 'stepAnimationCurve' instead, This feature was deprecated after v0.1.4+1")
    this.stepReachedAnimationEffect = Curves.linear,
    this.stepAnimationCurve,
    @Deprecated(
        "use 'stepAnimationDuration' instead, This feature was deprecated after v0.1.4+1")
    this.stepReachedAnimationDuration = const Duration(seconds: 1),
    this.stepAnimationDuration,
    this.borderThickness = 0.8,
    this.loadingAnimation,
    this.stepShape = StepShape.circle,
    this.stepBorderRadius,
    this.defaultStepBorderType = BorderType.dotted,
    this.unreachedStepBorderType,
    this.activeStepBorderType,
    this.finishedStepBorderType,
    this.dashPattern = const [3, 1],
    this.showStepBorder = true,
    this.showLoadingAnimation = true,
    this.textDirection = TextDirection.ltr,
  }) : super(key: key);

  @override
  State<EasyStepper> createState() => _EasyStepperState();
}

class _EasyStepperState extends State<EasyStepper> {
  ScrollController? _scrollController;
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.activeStep;
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void didUpdateWidget(EasyStepper oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Verify that the active step falls within a valid range.
    if (widget.activeStep >= 0 && widget.activeStep < widget.steps.length) {
      _selectedIndex = widget.activeStep;
    }
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  /// Controls the step scrolling.
  void _afterLayout(_) {
    // ! Provide detailed explanation.
    for (int i = 0; i < widget.steps.length; i++) {
      _scrollController!.animateTo(
        i *
            (widget.stepRadius +
                widget.internalPadding +
                widget.lineLength +
                (widget.direction == Axis.vertical
                    ? widget.padding.vertical
                    : widget.padding.horizontal)),
        duration:
            widget.stepAnimationDuration ?? widget.stepReachedAnimationDuration,
        curve: widget.stepAnimationCurve ?? widget.stepReachedAnimationEffect,
      );

      if (_selectedIndex == i) break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Controls scrolling behavior.
    if (!widget.disableScroll) {
      WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    }

    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: Align(
        alignment: widget.alignment,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: widget.disableScroll
              ? widget.direction == Axis.horizontal
                  ? FittedBox(
                      fit: widget.fitWidth ? BoxFit.fitWidth : BoxFit.none,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _buildEasySteps(),
                      ),
                    )
                  : Column(
                      children: _buildEasySteps(),
                    )
              : ((kIsWeb ||
                          Platform.isWindows ||
                          Platform.isMacOS ||
                          Platform.isLinux) &&
                      widget.showScrollbar)
                  ? Scrollbar(
                      controller: _scrollController,
                      child: SingleChildScrollView(
                        scrollDirection: widget.direction,
                        physics: const ClampingScrollPhysics(),
                        controller: _scrollController,
                        padding: widget.padding,
                        child: widget.direction == Axis.horizontal
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: _buildEasySteps(),
                              )
                            : Column(
                                children: _buildEasySteps(),
                              ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: widget.direction,
                      physics: const ClampingScrollPhysics(),
                      controller: _scrollController,
                      padding: widget.padding,
                      child: widget.direction == Axis.horizontal
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: _buildEasySteps(),
                            )
                          : Column(
                              children: _buildEasySteps(),
                            ),
                    ),
        ),
      ),
    );
  }

  List<Widget> _buildEasySteps() {
    return List.generate(widget.steps.length, (index) {
      return widget.direction == Axis.horizontal
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildStep(index),
                _buildDottedLine(index, Axis.horizontal),
              ],
            )
          : Column(
              children: <Widget>[
                _buildStep(index),
                _buildDottedLine(index, Axis.vertical),
              ],
            );
    });
  }

  BaseStep _buildStep(int index) {
    final step = widget.steps[index];
    return BaseStep(
      step: step,
      radius: widget.stepRadius,
      showTitle: widget.showTitle,
      borderThickness: widget.borderThickness,
      isActive: index == widget.activeStep,
      isFinished: index < widget.activeStep,
      isUnreached: index > widget.activeStep,
      isAlreadyReached: widget.maxReachedStep != null
          ? index <= widget.maxReachedStep!
          : false,
      activeStepBackgroundColor: widget.activeStepBackgroundColor,
      activeStepBorderColor: widget.activeStepBorderColor,
      activeTextColor: widget.activeStepTextColor,
      activeIconColor: widget.activeStepIconColor,
      finishedBackgroundColor: widget.finishedStepBackgroundColor,
      finishedBorderColor: widget.finishedStepBorderColor,
      finishedTextColor: widget.finishedStepTextColor,
      finishedIconColor: widget.finishedStepIconColor,
      unreachedBackgroundColor: widget.unreachedStepBackgroundColor,
      unreachedBorderColor: widget.unreachedStepBorderColor,
      unreachedTextColor: widget.unreachedStepTextColor,
      unreachedIconColor: widget.unreachedStepIconColor,
      lottieAnimation: widget.loadingAnimation,
      padding: max(widget.internalPadding,
          (widget.direction == Axis.vertical ? widget.padding.horizontal : 0)),
      stepShape: widget.stepShape,
      stepRadius: widget.stepBorderRadius,
      borderType: _handleBorderType(index),
      dashPattern: widget.dashPattern,
      showStepBorder: widget.showStepBorder,
      showLoadingAnimation: widget.showLoadingAnimation,
      textDirection: widget.textDirection,
      lineLength: widget.lineLength,
      enabled: widget.steps[index].enabled,
      direction: widget.direction,
      onStepSelected: widget.enableStepTapping
          ? () {
              if (widget.steppingEnabled && widget.steps[index].enabled ||
                  index < _selectedIndex) {
                setState(() {
                  _selectedIndex = index;

                  widget.onStepReached?.call(_selectedIndex);
                });
              }
            }
          : null,
    );
  }

  BorderType _handleBorderType(int index) {
    if (index == widget.activeStep) {
      //Active Step
      return widget.activeStepBorderType ?? widget.defaultStepBorderType;
    } else if (index > widget.activeStep) {
      //Unreached Step
      return widget.unreachedStepBorderType ?? widget.defaultStepBorderType;
    } else if (index < widget.activeStep) {
      //Finished Step
      return widget.finishedStepBorderType ?? widget.defaultStepBorderType;
    } else {
      return widget.defaultStepBorderType;
    }
  }

  Color _getLineColor(int index) {
    Color? preferredColor;
    if (index == widget.activeStep) {
      //Active Step
      preferredColor = widget.activeLineColor;
    } else if (index > widget.activeStep) {
      //Unreached Step
      preferredColor = widget.unreachedLineColor;
    } else if (index < widget.activeStep) {
      //Finished Step
      preferredColor = widget.finishedLineColor;
    }

    return preferredColor ??
        widget.defaultLineColor ??
        Theme.of(context).colorScheme.primary;
  }

  Widget _buildDottedLine(int index, Axis axis) {
    return index < widget.steps.length - 1
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: axis == Axis.horizontal
                      ? (widget.stepRadius -
                          (widget.lineDotRadius ?? widget.lineThickness))
                      : 0,
                  bottom: axis == Axis.vertical && widget.showTitle ? 10 : 0,
                ),
                child: EasyLine(
                  length: widget.lineLength,
                  color: _getLineColor(index),
                  thickness: widget.lineDotRadius ?? widget.lineThickness,
                  spacing: widget.lineSpace,
                  axis: axis,
                  lineType: widget.lineType,
                ),
              ),
              if (axis == Axis.horizontal &&
                  widget.steps[index].lineText != null) ...[
                const SizedBox(height: 5),
                SizedBox(
                  width: widget.lineLength,
                  child: widget.steps[index].customLineWidget ??
                      Text(
                        widget.steps[index].lineText!,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                ),
              ],
            ],
          )
        : const Offstage();
  }
}
