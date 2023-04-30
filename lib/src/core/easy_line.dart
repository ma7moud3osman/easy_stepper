import 'package:flutter/material.dart';

class EasyLine extends StatelessWidget {
  /// Width of the dotted line.
  final double length;

  /// Color of the dotted line.
  final Color color;

  /// Radius of each dot in the dotted line.
  final double thickness;

  /// Spacing between the dots in the dotted line.
  final double spacing;

  /// The type of the line [normal, dotted].
  final LineType lineType;

  /// Line Axis.
  final Axis axis;

  const EasyLine({
    key,
    this.length = 50.0,
    this.color = Colors.grey,
    this.thickness = 1.5,
    this.spacing = 3.0,
    this.lineType = LineType.dotted,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // If this is not applied, top half of the dot gets offscreen, hence, hidden.
      margin: EdgeInsets.only(top: lineType == LineType.dotted ? thickness : 0),
      width: axis == Axis.horizontal
          ? length
          : lineType == LineType.normal
              ? thickness * 2
              : 0,
      height: axis == Axis.vertical
          ? length
          : lineType == LineType.normal
              ? thickness * 2
              : 0,
      decoration: lineType == LineType.normal
          ? BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
            )
          : null,
      child: lineType == LineType.dotted
          ? CustomPaint(
              painter: _DottedLinePainter(
                brush: Paint()..color = color,
                length: length,
                dotRadius: thickness,
                spacing: lineType == LineType.normal ? 0.0 : spacing,
                axis: axis,
              ),
            )
          : null,
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final double length;
  final double dotRadius;
  final double spacing;
  final Paint brush;
  final Axis axis;

  _DottedLinePainter({
    this.length = 100,
    required this.brush,
    this.dotRadius = 2.0,
    this.spacing = 3.0,
    this.axis = Axis.horizontal,
  }) : assert(dotRadius > 0, 'dotRadius must be greater than 0');

  @override
  void paint(Canvas canvas, Size size) {
    double start = 0.0;

    // Length of the line is calculated by dividing the supplied length [to] by dotRadius * space.

    late final int calculatedLength;
    if (spacing == 0) {
      calculatedLength = length ~/ dotRadius;
    } else {
      calculatedLength = length ~/ (dotRadius * spacing);
    }

    for (int i = 1; i < calculatedLength; i++) {
      // New start becomes:
      if (spacing == 0) {
        start += dotRadius;
      } else {
        start += dotRadius * spacing;
      }

      canvas.drawCircle(
        Offset(
          axis == Axis.horizontal ? start : 0.0,
          axis == Axis.horizontal ? 0.0 : start,
        ),
        dotRadius,
        brush,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

enum LineType {
  ///Straight line with solid color. Hence, choose normal line ignoring line space.
  normal,

  /// Dotted line with space between dots.
  dotted,
}
