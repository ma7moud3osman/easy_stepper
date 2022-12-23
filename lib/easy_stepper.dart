library easy_stepper;

import 'package:easy_stepper/src/easy_step.dart';

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

  /// The color of a step background when it is reached.
  final Color? activeStepBackgroundColor;

  /// The color of a step text and icon when it is reached.
  final Color? activeStepTextColor;

  /// The color of the step icon when it is reached.
  final Color? activeStepIconColor;

  /// The border color of a step when it is reached.
  final Color? activeStepBorderColor;

  /// The color of the step background when it is finished.
  final Color? finishedStepBackgroundColor;

  /// The border color of a step when it is finished.
  final Color? finishedStepBorderColor;

  /// The color of the step text and icon when it is finished.
  final Color? finishedStepTextColor;

  /// The color of the step icon when it is finished.
  final Color? finishedStepIconColor;

  /// The color of the line that separates the steps.
  final Color? lineColor;

  /// The radius of a step.
  final double stepRadius;

  /// Whether the stepping is enabled or disabled.
  final bool steppingEnabled;

  /// Whether the scrolling is disabled or not.
  final bool disableScroll;

  /// The index of currently active step.
  final int activeStep;

  /// Whether show step title or not.
  final bool showTitle;

  /// Specifies the alignment of IconStepper widget.
  final AlignmentGeometry alignment;

  /// The length of the line that separates the steps.
  final double lineLength;

  /// The radius of individual dot within the line that separates the steps.
  final double lineDotRadius;

  /// The space between individual dot within the line that separates the steps.
  final double lineSpace;

  /// The type of the line [normal, dotted].
  final LineType lineType;

  /// The amount of padding around the stepper.
  final double padding;

  @Deprecated(
      "use 'stepAnimationCurve' instead, This feature was deprecated after v0.1.4+1")

  /// The animation effect to show when a step is reached.
  final Curve stepReachedAnimationEffect;

  /// The curve of the animation to show when a step is reached.
  final Curve? stepAnimationCurve;

  @Deprecated(
      "use 'stepAnimationDuration' instead, This feature was deprecated after v0.1.4+1")

  /// The duration of the animation effect to show when a step is reached.
  final Duration stepReachedAnimationDuration;

  /// The duration of the animation effect to show when a step is reached.
  final Duration? stepAnimationDuration;

  ///The thickness of the step border.
  final double? borderThickness;

  ///The loading animation shows when the step is active. Hence, use lottie json files only by adding its path.
  final String? loadingAnimation;

  const EasyStepper({
    Key? key,
    required this.activeStep,
    required this.steps,
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
    this.lineColor,
    this.stepRadius = 30,
    this.steppingEnabled = true,
    this.disableScroll = false,
    this.showTitle = true,
    this.alignment = Alignment.center,
    this.lineLength = 40,
    this.lineDotRadius = 1,
    this.lineSpace = 5,
    this.padding = 8,
    this.stepReachedAnimationEffect = Curves.linear,
    this.stepAnimationCurve,
    this.stepReachedAnimationDuration = const Duration(seconds: 1),
    this.stepAnimationDuration,
    this.borderThickness,
    this.loadingAnimation,
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
        i * ((widget.stepRadius * 1) + widget.lineLength),
        duration:
            // ignore: deprecated_member_use_from_same_package
            widget.stepAnimationDuration ?? widget.stepReachedAnimationDuration,
        // ignore: deprecated_member_use_from_same_package
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

    return Align(
      alignment: widget.alignment,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          scrollDirection: widget.direction,
          physics: widget.disableScroll
              ? const NeverScrollableScrollPhysics()
              : const ClampingScrollPhysics(),
          controller: _scrollController,
          padding: EdgeInsets.all(widget.padding),
          child: widget.direction == Axis.horizontal
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildEasySteps(),
                )
              : Column(
                  children: _buildEasySteps(),
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
      onStepSelected: widget.enableStepTapping
          ? () {
              if (widget.steppingEnabled) {
                setState(() {
                  _selectedIndex = index;

                  widget.onStepReached?.call(_selectedIndex);
                });
              }
            }
          : null,
    );
  }

  Widget _buildDottedLine(int index, Axis axis) {
    return index < widget.steps.length - 1
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: axis == Axis.horizontal
                      ? (widget.stepRadius - widget.lineDotRadius)
                      : 0,
                  bottom: axis == Axis.vertical && widget.showTitle ? 10 : 0,
                ),
                child: EasyLine(
                  length: widget.lineLength,
                  color: widget.lineColor ?? Colors.blue,
                  dotRadius: widget.lineDotRadius,
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
                  child: Text(
                    widget.steps[index].lineText!,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
              ],
            ],
          )
        : const Offstage();
  }
}
