import 'package:flutter/material.dart';

class EasyLine extends StatelessWidget {
  const EasyLine({
    Key? key,
    this.length = 50.0,
    this.color = Colors.grey,
    this.thickness = 3,
    this.spacing = 3.0,
    this.width = 2.0,
    this.lineType = LineType.dotted,
    this.axis = Axis.horizontal,
    required this.borderRadius,
  }) : super(key: key);

  /// Width of the dotted line.
  final double length;

  /// Width of the dashes.
  final double width;

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

  /// Line Border radius.
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: axis == Axis.horizontal
          ? length
          : lineType == LineType.dotted
              ? thickness * 2
              : thickness,
      height: axis == Axis.vertical
          ? length
          : lineType == LineType.dotted
              ? thickness * 2
              : thickness,
      decoration: lineType == LineType.normal
          ? BoxDecoration(
              color: color,
              borderRadius: borderRadius,
            )
          : null,
      child: lineType == LineType.dotted
          ? CustomPaint(
              painter: _DottedLinePainter(
                brush: Paint()..color = color,
                length: length,
                dotRadius: thickness,
                spacing: spacing,
                axis: axis,
              ),
            )
          : lineType == LineType.dashed
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    final double effectiveLength = length == double.infinity
                        ? (axis == Axis.horizontal
                            ? constraints.maxWidth
                            : constraints.maxHeight)
                        : length;

                    if (axis == Axis.vertical) {
                      return Column(
                          children: List.generate(
                        effectiveLength ~/ ((width + spacing) / 2),
                        (index) => Expanded(
                          child: index % 2 == 0
                              ? Container(
                                  color: color,
                                  height: width,
                                  width: thickness,
                                )
                              : SizedBox(
                                  width: thickness,
                                  height: spacing,
                                ),
                        ),
                      ));
                    }
                    return Row(
                      children: List.generate(
                        effectiveLength ~/ ((width + spacing) / 2),
                        (index) => Expanded(
                          child: index % 2 == 0
                              ? Container(
                                  color: color,
                                  height: thickness,
                                  width: width,
                                )
                              : SizedBox(
                                  width: spacing,
                                  height: thickness,
                                ),
                        ),
                      ),
                    );
                  },
                )
              : null,
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  _DottedLinePainter({
    this.length = 100,
    required this.brush,
    this.dotRadius = 2.0,
    this.spacing = 3.0,
    this.axis = Axis.horizontal,
  }) : assert(dotRadius > 0, 'dotRadius must be greater than 0');
  final double length;
  final double dotRadius;
  final double spacing;
  final Paint brush;
  final Axis axis;

  @override
  void paint(Canvas canvas, Size size) {
    double start = 0.0;

    final double effectiveLength =
        axis == Axis.horizontal ? size.width : size.height;

    // Length of the line is calculated by dividing the supplied length [to] by dotRadius * space.

    late final int calculatedLength;
    if (spacing == 0) {
      calculatedLength = effectiveLength ~/ dotRadius;
    } else {
      calculatedLength = effectiveLength ~/ (dotRadius * spacing);
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
          axis == Axis.horizontal ? start : dotRadius,
          axis == Axis.horizontal ? dotRadius : start,
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

  /// Dashed line with space between dashes.
  dashed,
}
