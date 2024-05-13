import 'package:flutter/material.dart';
import 'package:flutter_drawing_line/drawing_line.dart';
import 'package:flutter_drawing_line/points.dart';

class Brush extends StatefulWidget {
  const Brush({super.key});

  @override
  State<Brush> createState() => _BrushState();
}

class _BrushState extends State<Brush> {
  List<Points> points = [];

  void brushOnPanStart(DragStartDetails details) {
    setState(() {
      points.add(
        Points(
          offset: details.localPosition,
          paint: Paint()
            ..color = Colors.black
            ..isAntiAlias = true
            ..strokeWidth = 0.5
            ..strokeCap = StrokeCap.round,
        ),
      );
    });
  }

  void brushOnPanUpdate(DragUpdateDetails details) {
    setState(() {
      points.add(Points(
        offset: details.localPosition,
        paint: Paint()
          ..color = Colors.black
          ..isAntiAlias = true
          ..strokeWidth = 0.5
          ..strokeCap = StrokeCap.round,
      ));
    });
  }

  void brushOnPanEnd(DragEndDetails details) {
    setState(() {
      points.add(Points(offset: null, paint: null));
    });
  }

  List<Widget> dataStack() {
    List<Widget> data = [];
    for (var i = 0; i < points.length; i++) {
      data.add(
        CustomPaint(
          painter: DrawingLine(points),
        ),
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: GestureDetector(
          onPanStart: (DragStartDetails details) => brushOnPanStart(details),
          onPanUpdate: (DragUpdateDetails details) => brushOnPanUpdate(details),
          onPanEnd: (DragEndDetails details) => brushOnPanEnd(details),
          child: Container(
            width: 300,
            height: 500,
            color: Colors.white,
            child: Stack(
              children: dataStack(),
            ),
          ),
        ),
      ),
    );
  }
}
