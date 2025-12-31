library easy_stepper;

import 'dart:math';

import 'package:easy_stepper/src/core/custom_scroll_behavior.dart';
import 'package:easy_stepper/src/core/line_style.dart';
import 'package:easy_stepper/src/core/step_builder.dart';
import 'package:easy_stepper/src/easy_step.dart';
import 'package:flutter/material.dart';

import 'src/utils/platform_stub.dart'
    if (dart.library.io) 'src/utils/platform_io.dart';

export 'package:easy_stepper/src/core/line_style.dart';
export 'package:easy_stepper/src/easy_step.dart';

/// A customizable stepper widget for Flutter.
///
/// It supports horizontal and vertical orientations, custom step shapes,
/// custom colors, and various line styles.
class EasyStepper extends StatefulWidget {
  const EasyStepper({
    Key? key,
    required this.activeStep,
    required this.steps,
    this.reachedSteps,
    this.maxReachedStep,
    this.enableStepTapping = true,
    this.direction = Axis.horizontal,
    this.onStepReached,
    this.unreachedStepBackgroundColor,
    this.unreachedStepTextColor,
    this.unreachedStepIconColor,
    this.unreachedStepBorderColor,
    this.unreachedStepBoxShadow,
    this.activeStepTextColor,
    this.activeStepIconColor,
    this.activeStepBackgroundColor,
    this.activeStepBorderColor,
    this.activeStepBoxShadow,
    this.finishedStepTextColor,
    this.finishedStepBackgroundColor,
    this.finishedStepBorderColor,
    this.finishedStepIconColor,
    this.finishedStepBoxShadow,
    this.stepRadius = 30,
    this.steppingEnabled = true,
    this.disableScroll = false,
    this.showTitle = true,
    this.alignment = Alignment.center,
    this.fitWidth = true,
    this.showScrollbar = false,
    this.padding,
    this.titlesAreLargerThanSteps = false,
    this.internalPadding = 8,
    this.stepAnimationCurve = Curves.linear,
    this.stepAnimationDuration = const Duration(seconds: 1),
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
    this.textDirection,
    this.lineStyle,
    this.maxTitleLines = 2,
    this.titleTextStyle,
  })  : assert(maxReachedStep == null || reachedSteps == null,
            'only "maxReachedStep" or "reachedSteps" allowed'),
        super(key: key);

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

  /// The shadow of the step when it is not reached.
  final List<BoxShadow>? unreachedStepBoxShadow;

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

  /// The shadow of the step when it is reached.
  final List<BoxShadow>? activeStepBoxShadow;

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

  /// The shadow of the step when it is finished.
  final List<BoxShadow>? finishedStepBoxShadow;

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

  /// A set of already reached steps
  final Set<int>? reachedSteps;

  /// Whether show step title or not.
  final bool showTitle;

  /// Specifies the alignment of IconStepper widget.
  final AlignmentGeometry alignment;

  /// The amount of padding around every step.
  final double internalPadding;

  /// The amount of padding around the stepper.
  final EdgeInsetsGeometry? padding;

  /// Set this to true if the titles (of at least the first or last step) are wider than the step itself.
  /// This will allow the stepper to correctly pad them so that the titles don't get cut off.
  /// Hence, this will be ignored if padding is already set
  final bool titlesAreLargerThanSteps;

  /// The curve of the animation to show when a step is reached.
  final Curve stepAnimationCurve;

  /// The duration of the animation effect to show when a step is reached.
  final Duration stepAnimationDuration;

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
  final TextDirection? textDirection;

  /// Show `Scrollbar` in Web or Desktop. default `True`.
  final bool showScrollbar;

  /// Whether the stepper take the full width of the screen or not, this property work when `disableScroll = true`. default `True`.
  final bool fitWidth;

  //All Styles to customize line between steps
  final LineStyle? lineStyle;

  /// The maximum number of lines for step title
  final int maxTitleLines;

  /// The text style of step title
  final TextStyle? titleTextStyle;

  @override
  State<EasyStepper> createState() => _EasyStepperState();
}

class _EasyStepperState extends State<EasyStepper> {
  ScrollController? _scrollController;
  late int _selectedIndex;
  late LineStyle lineStyle;
  late EdgeInsetsGeometry _padding;

  @override
  void initState() {
    lineStyle = widget.lineStyle ?? const LineStyle();
    _selectedIndex = widget.activeStep;
    _scrollController = ScrollController();

    _padding = widget.padding ?? const EdgeInsets.all(0);

    if (widget.direction == Axis.horizontal) {
      if (widget.steps
          .any((element) => element.placeTitleAtStart || element.topTitle)) {
        _padding = _padding
            .add(EdgeInsetsDirectional.only(top: widget.maxTitleLines * 22));
      }
      if (widget.titlesAreLargerThanSteps) {
        _padding = _padding.add(
          EdgeInsetsDirectional.symmetric(horizontal: lineStyle.lineLength / 2),
        );
      }
    }
    super.initState();
  }

  @override
  void didUpdateWidget(EasyStepper oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Verify that the active step falls within a valid range.
    if (widget.activeStep >= 0 && widget.activeStep < widget.steps.length) {
      _selectedIndex = widget.activeStep;
    }

    if (widget.padding != oldWidget.padding) {
      _padding = widget.padding ?? const EdgeInsets.all(0);

      if (widget.direction == Axis.horizontal) {
        if (widget.steps
            .any((element) => element.placeTitleAtStart || element.topTitle)) {
          _padding = _padding
              .add(EdgeInsetsDirectional.only(top: widget.maxTitleLines * 22));
        }
        if (widget.titlesAreLargerThanSteps) {
          _padding = _padding.add(
            EdgeInsetsDirectional.symmetric(
                horizontal: lineStyle.lineLength / 2),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  /// Controls the step scrolling.
  void _afterLayout(Duration duration) {
    if (lineStyle.lineLength == double.infinity ||
        !_scrollController!.hasClients) {
      return;
    }
    for (int i = 0; i < widget.steps.length; i++) {
      _scrollController!.animateTo(
        i *
            ((widget.stepRadius * 2) +
                widget.internalPadding +
                lineStyle.lineLength),
        duration: widget.stepAnimationDuration,
        curve: widget.stepAnimationCurve,
      );

      if (_selectedIndex == i) {
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    lineStyle = widget.lineStyle ?? const LineStyle();
    // Controls scrolling behavior.
    if (!widget.disableScroll && lineStyle.lineLength != double.infinity) {
      WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    }

    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: Align(
        alignment: widget.alignment,
        heightFactor: lineStyle.lineLength == double.infinity ? null : 1,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: widget.disableScroll || lineStyle.lineLength == double.infinity
              ? widget.direction == Axis.horizontal
                  ? lineStyle.lineLength == double.infinity
                      ? LayoutBuilder(
                          builder: (context, constraints) {
                            return Padding(
                              padding: _padding,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildEasySteps(constraints.maxWidth),
                              ),
                            );
                          },
                        )
                      : FittedBox(
                          fit: widget.fitWidth ? BoxFit.fitWidth : BoxFit.none,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _buildEasySteps(),
                          ),
                        )
                  : Padding(
                      padding: _padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _buildEasySteps(),
                      ),
                    )
              : ((!widget.disableScroll &&
                          lineStyle.lineLength != double.infinity &&
                          widget.showScrollbar) ||
                      (!isMobile &&
                          !widget.disableScroll &&
                          lineStyle.lineLength != double.infinity))
                  ? RawScrollbar(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(top: 8),
                      crossAxisMargin: 8,
                      child: SingleChildScrollView(
                        scrollDirection: widget.direction,
                        physics: const ClampingScrollPhysics(),
                        controller: _scrollController,
                        padding: _padding,
                        child: widget.direction == Axis.horizontal
                            ? IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: _buildEasySteps(),
                                ),
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
                      padding: _padding,
                      child: widget.direction == Axis.horizontal
                          ? IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: _buildEasySteps(),
                              ),
                            )
                          : Column(
                              children: _buildEasySteps(),
                            ),
                    ),
        ),
      ),
    );
  }

  List<Widget> _buildEasySteps([double? maxWidth]) {
    if (lineStyle.lineLength == double.infinity) {
      double? flexibleLineLength;
      if (maxWidth != null && widget.direction == Axis.horizontal) {
        // Calculate dynamic line length for StepBuilder to constrain text
        final totalStepsWidth = widget.steps.length * (widget.stepRadius * 2);
        final totalInternalPadding =
            (widget.steps.length - 1) * widget.internalPadding;
        final availableWidth = maxWidth -
            totalStepsWidth -
            totalInternalPadding -
            _padding.horizontal;
        flexibleLineLength = max(0, availableWidth / (widget.steps.length - 1));
      }

      return widget.steps.asMap().entries.expand((entry) {
        final int index = entry.key;
        final list = <Widget>[
          StepBuilder(
            index: index,
            step: widget.steps[index],
            activeStep: widget.activeStep,
            reachedSteps: widget.reachedSteps,
            maxReachedStep: widget.maxReachedStep,
            activeStepBackgroundColor: widget.activeStepBackgroundColor,
            activeStepBorderColor: widget.activeStepBorderColor,
            activeStepTextColor: widget.activeStepTextColor,
            activeStepIconColor: widget.activeStepIconColor,
            activeStepBoxShadow: widget.activeStepBoxShadow,
            finishedStepBackgroundColor: widget.finishedStepBackgroundColor,
            finishedStepBorderColor: widget.finishedStepBorderColor,
            finishedStepTextColor: widget.finishedStepTextColor,
            finishedStepIconColor: widget.finishedStepIconColor,
            finishedStepBoxShadow: widget.finishedStepBoxShadow,
            unreachedStepBackgroundColor: widget.unreachedStepBackgroundColor,
            unreachedStepBorderColor: widget.unreachedStepBorderColor,
            unreachedStepTextColor: widget.unreachedStepTextColor,
            unreachedStepIconColor: widget.unreachedStepIconColor,
            unreachedStepBoxShadow: widget.unreachedStepBoxShadow,
            stepRadius: widget.stepRadius,
            showScrollbar: widget.showScrollbar,
            showTitle: widget.showTitle,
            borderThickness: widget.borderThickness,
            loadingAnimation: widget.loadingAnimation,
            padding: widget.direction == Axis.horizontal
                ? 0
                : max(widget.internalPadding, _padding.horizontal),
            stepShape: widget.stepShape,
            stepBorderRadius: widget.stepBorderRadius,
            defaultStepBorderType: widget.defaultStepBorderType,
            activeStepBorderType: widget.activeStepBorderType,
            unreachedStepBorderType: widget.unreachedStepBorderType,
            finishedStepBorderType: widget.finishedStepBorderType,
            dashPattern: widget.dashPattern,
            showStepBorder: widget.showStepBorder,
            showLoadingAnimation: widget.showLoadingAnimation,
            textDirection: widget.textDirection,
            lineLength: flexibleLineLength ?? lineStyle.lineLength,
            enabled: widget.steps[index].enabled,
            direction: widget.direction,
            maxTitleLines: widget.maxTitleLines,
            titleTextStyle: widget.titleTextStyle,
            enableStepTapping: widget.enableStepTapping,
            steppingEnabled: widget.steppingEnabled,
            selectedIndex: _selectedIndex,
            onStepReached: widget.onStepReached,
            onStepSelected: () {
              if (widget.steppingEnabled && widget.steps[index].enabled ||
                  index < _selectedIndex) {
                setState(() {
                  _selectedIndex = index;
                  widget.onStepReached?.call(_selectedIndex);
                });
              }
            },
          ),
        ];

        if (index < widget.steps.length - 1) {
          if (widget.direction == Axis.horizontal) {
            list.add(SizedBox(width: widget.internalPadding / 2));
            list.add(
              Expanded(
                child: _buildLine(index, widget.direction),
              ),
            );
            list.add(SizedBox(width: widget.internalPadding / 2));
          } else {
            list.add(
              Expanded(
                child: _buildLine(index, widget.direction),
              ),
            );
          }
        }

        return list;
      }).toList();
    }

    return List.generate(
      widget.steps.length,
      (index) {
        return widget.direction == Axis.horizontal
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StepBuilder(
                    index: index,
                    step: widget.steps[index],
                    activeStep: widget.activeStep,
                    reachedSteps: widget.reachedSteps,
                    maxReachedStep: widget.maxReachedStep,
                    activeStepBackgroundColor: widget.activeStepBackgroundColor,
                    activeStepBorderColor: widget.activeStepBorderColor,
                    activeStepTextColor: widget.activeStepTextColor,
                    activeStepIconColor: widget.activeStepIconColor,
                    activeStepBoxShadow: widget.activeStepBoxShadow,
                    finishedStepBackgroundColor:
                        widget.finishedStepBackgroundColor,
                    finishedStepBorderColor: widget.finishedStepBorderColor,
                    finishedStepTextColor: widget.finishedStepTextColor,
                    finishedStepIconColor: widget.finishedStepIconColor,
                    finishedStepBoxShadow: widget.finishedStepBoxShadow,
                    unreachedStepBackgroundColor:
                        widget.unreachedStepBackgroundColor,
                    unreachedStepBorderColor: widget.unreachedStepBorderColor,
                    unreachedStepTextColor: widget.unreachedStepTextColor,
                    unreachedStepIconColor: widget.unreachedStepIconColor,
                    unreachedStepBoxShadow: widget.unreachedStepBoxShadow,
                    stepRadius: widget.stepRadius,
                    showScrollbar: widget.showScrollbar,
                    showTitle: widget.showTitle,
                    borderThickness: widget.borderThickness,
                    loadingAnimation: widget.loadingAnimation,
                    padding: max(
                        widget.internalPadding,
                        (widget.direction == Axis.vertical
                            ? _padding.horizontal
                            : 0)),
                    stepShape: widget.stepShape,
                    stepBorderRadius: widget.stepBorderRadius,
                    defaultStepBorderType: widget.defaultStepBorderType,
                    activeStepBorderType: widget.activeStepBorderType,
                    unreachedStepBorderType: widget.unreachedStepBorderType,
                    finishedStepBorderType: widget.finishedStepBorderType,
                    dashPattern: widget.dashPattern,
                    showStepBorder: widget.showStepBorder,
                    showLoadingAnimation: widget.showLoadingAnimation,
                    textDirection: widget.textDirection,
                    lineLength: lineStyle.lineLength,
                    enabled: widget.steps[index].enabled,
                    direction: widget.direction,
                    maxTitleLines: widget.maxTitleLines,
                    titleTextStyle: widget.titleTextStyle,
                    enableStepTapping: widget.enableStepTapping,
                    steppingEnabled: widget.steppingEnabled,
                    selectedIndex: _selectedIndex,
                    onStepReached: widget.onStepReached,
                    onStepSelected: () {
                      if (widget.steppingEnabled &&
                              widget.steps[index].enabled ||
                          index < _selectedIndex) {
                        setState(() {
                          _selectedIndex = index;
                          widget.onStepReached?.call(_selectedIndex);
                        });
                      }
                    },
                  ),
                  _buildLine(index, Axis.horizontal),
                ],
              )
            : Column(
                children: <Widget>[
                  StepBuilder(
                    index: index,
                    step: widget.steps[index],
                    activeStep: widget.activeStep,
                    reachedSteps: widget.reachedSteps,
                    maxReachedStep: widget.maxReachedStep,
                    activeStepBackgroundColor: widget.activeStepBackgroundColor,
                    activeStepBorderColor: widget.activeStepBorderColor,
                    activeStepTextColor: widget.activeStepTextColor,
                    activeStepIconColor: widget.activeStepIconColor,
                    activeStepBoxShadow: widget.activeStepBoxShadow,
                    finishedStepBackgroundColor:
                        widget.finishedStepBackgroundColor,
                    finishedStepBorderColor: widget.finishedStepBorderColor,
                    finishedStepTextColor: widget.finishedStepTextColor,
                    finishedStepIconColor: widget.finishedStepIconColor,
                    finishedStepBoxShadow: widget.finishedStepBoxShadow,
                    unreachedStepBackgroundColor:
                        widget.unreachedStepBackgroundColor,
                    unreachedStepBorderColor: widget.unreachedStepBorderColor,
                    unreachedStepTextColor: widget.unreachedStepTextColor,
                    unreachedStepIconColor: widget.unreachedStepIconColor,
                    unreachedStepBoxShadow: widget.unreachedStepBoxShadow,
                    stepRadius: widget.stepRadius,
                    showScrollbar: widget.showScrollbar,
                    showTitle: widget.showTitle,
                    borderThickness: widget.borderThickness,
                    loadingAnimation: widget.loadingAnimation,
                    padding: max(
                        widget.internalPadding,
                        (widget.direction == Axis.vertical
                            ? _padding.horizontal
                            : 0)),
                    stepShape: widget.stepShape,
                    stepBorderRadius: widget.stepBorderRadius,
                    defaultStepBorderType: widget.defaultStepBorderType,
                    activeStepBorderType: widget.activeStepBorderType,
                    unreachedStepBorderType: widget.unreachedStepBorderType,
                    finishedStepBorderType: widget.finishedStepBorderType,
                    dashPattern: widget.dashPattern,
                    showStepBorder: widget.showStepBorder,
                    showLoadingAnimation: widget.showLoadingAnimation,
                    textDirection: widget.textDirection,
                    lineLength: lineStyle.lineLength,
                    enabled: widget.steps[index].enabled,
                    direction: widget.direction,
                    maxTitleLines: widget.maxTitleLines,
                    titleTextStyle: widget.titleTextStyle,
                    enableStepTapping: widget.enableStepTapping,
                    steppingEnabled: widget.steppingEnabled,
                    selectedIndex: _selectedIndex,
                    onStepReached: widget.onStepReached,
                    onStepSelected: () {
                      if (widget.steppingEnabled &&
                              widget.steps[index].enabled ||
                          index < _selectedIndex) {
                        setState(() {
                          _selectedIndex = index;
                          widget.onStepReached?.call(_selectedIndex);
                        });
                      }
                    },
                  ),
                  _buildLine(index, Axis.vertical),
                ],
              );
      },
    );
  }

  Color _getLineColor(int index) {
    Color? preferredColor;
    if (index == widget.activeStep) {
      //Active Step
      preferredColor = lineStyle.activeLineColor;
    } else if (index > widget.activeStep) {
      //Unreached Step
      preferredColor = lineStyle.unreachedLineColor;
    } else if (index < widget.activeStep) {
      //Finished Step
      preferredColor = lineStyle.progressColor ?? lineStyle.finishedLineColor;
    }

    return preferredColor ??
        lineStyle.defaultLineColor ??
        Theme.of(context).colorScheme.primary;
  }

  Widget _buildLine(int index, Axis axis) {
    final step = widget.steps[index];
    final isVertical = axis == Axis.vertical;

    return index < widget.steps.length - 1
        ? isVertical
            ? Stack(
                alignment: Alignment.center,
                children: [
                  if (lineStyle.lineLength == double.infinity)
                    PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: axis == Axis.horizontal
                              ? (widget.stepRadius -
                                  (lineStyle.lineThickness / 2))
                              : 0,
                          bottom: 0,
                        ),
                        child: lineStyle.progress != null &&
                                index == widget.activeStep
                            ? _buildProgressLine(index, axis)
                            : _buildBaseLine(index, axis),
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.only(
                        top: axis == Axis.horizontal
                            ? (widget.stepRadius -
                                (lineStyle.lineThickness / 2))
                            : 0,
                        bottom: 0,
                      ),
                      child: lineStyle.progress != null &&
                              index == widget.activeStep
                          ? _buildProgressLine(index, axis)
                          : _buildBaseLine(index, axis),
                    ),
                  if (step.lineText != null)
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: step.customLineWidget ??
                          Text(
                            step.lineText!,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                    ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (lineStyle.lineLength == double.infinity)
                    Padding(
                      padding: EdgeInsets.only(
                        top: axis == Axis.horizontal
                            ? (widget.stepRadius -
                                (lineStyle.lineThickness / 2))
                            : 0,
                        bottom: 0,
                      ),
                      child: lineStyle.progress != null &&
                              index == widget.activeStep
                          ? _buildProgressLine(index, axis)
                          : _buildBaseLine(index, axis),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.only(
                        top: axis == Axis.horizontal
                            ? (widget.stepRadius -
                                (lineStyle.lineThickness / 2))
                            : 0,
                        bottom: 0,
                      ),
                      child: lineStyle.progress != null &&
                              index == widget.activeStep
                          ? _buildProgressLine(index, axis)
                          : _buildBaseLine(index, axis),
                    ),
                  if (step.lineText != null) ...[
                    const SizedBox(height: 4),
                    SizedBox(
                      width: lineStyle.lineLength == double.infinity
                          ? null
                          : lineStyle.lineLength,
                      child: step.customLineWidget ??
                          Text(
                            step.lineText!,
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

  Stack _buildProgressLine(int index, Axis axis) {
    final progress = validateProgressValue;
    return Stack(
      children: [
        _buildBaseLine(index, axis),
        PositionedDirectional(
          start: 0,
          top: 0,
          bottom: 0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: lineStyle.lineThickness,
            width: lineStyle.lineLength * progress,
            decoration: BoxDecoration(
              borderRadius: lineStyle.borderRadius,
            ),
            clipBehavior: Clip.antiAlias,
            child: EasyLine(
              length: lineStyle.lineLength * progress,
              color: lineStyle.progressColor ??
                  lineStyle.activeLineColor ??
                  Theme.of(context).colorScheme.primary,
              thickness: lineStyle.lineThickness,
              spacing: lineStyle.lineSpace,
              axis: axis,
              lineType: lineStyle.lineType,
              borderRadius: lineStyle.borderRadius,
            ),
          ),
        ),
      ],
    );
  }

  EasyLine _buildBaseLine(int index, Axis axis) {
    return EasyLine(
      length: lineStyle.lineLength,
      color: _getLineColor(index),
      thickness: lineStyle.lineThickness,
      spacing: lineStyle.lineSpace,
      width: lineStyle.lineWidth,
      axis: axis,
      lineType:
          index > widget.activeStep - 1 && lineStyle.unreachedLineType != null
              ? lineStyle.unreachedLineType!
              : lineStyle.lineType,
      borderRadius: lineStyle.borderRadius,
    );
  }

  double get validateProgressValue {
    final progress = lineStyle.progress!;
    if (progress > 1) {
      return min(progress / 100.0, 1.0);
    } else if (progress < 0) {
      return 0.0;
    } else {
      return progress;
    }
  }
}
