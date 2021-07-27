import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vm;


class ProgressRing extends StatelessWidget {
  final double progress;
  final Color color;

  const ProgressRing(this.color, {Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox.expand(
          child: CustomPaint(
              painter: RingPainter(
                  color,
                  strokeWidth: constraints.maxWidth * 0.15,
                  progress: progress)));
    });
  }
}

class RingPainter extends CustomPainter {
  final double strokeWidth;
  final double progress;
  final Color color;

  RingPainter(this.color, {required this.strokeWidth, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final inset = size.width * 0.18;

    final rect =
    Rect.fromLTRB(inset, inset, size.width - inset, size.height - inset);

    canvas.drawArc(
        rect,
        vm.radians(-90),
        vm.radians(360 * progress),
        false,
        Paint()
          ..shader = LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                color.withOpacity(0.3),
                color.withOpacity(0.3)
              ]).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(RingPainter oldDelegate) {
    if (oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth) {
      return true;
    }
    return false;
  }
}
