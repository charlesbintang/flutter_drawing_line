import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_drawing_line/points.dart';

class DrawingLine extends CustomPainter {
  final List<Points> drawingPoints;

  DrawingLine(this.drawingPoints);
  List<Offset> offsetList = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < drawingPoints.length - 1; i++) {
      if (drawingPoints[i].offset != null &&
          drawingPoints[i + 1].offset != null) {
        canvas.drawLine(
            drawingPoints[i].offset as Offset,
            drawingPoints[i + 1].offset as Offset,
            drawingPoints[i].paint as Paint);
      } else if (drawingPoints[i].offset != null &&
          drawingPoints[i + 1].offset == null) {
        offsetList.clear();
        offsetList.add(drawingPoints[i].offset as Offset);

        canvas.drawPoints(
            PointMode.points, offsetList, drawingPoints[i].paint as Paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
