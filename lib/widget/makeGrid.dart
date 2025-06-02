
import 'package:flutter/material.dart';


class SelectableRectangle extends StatefulWidget {
  @override
  _SelectableRectangleState createState() => _SelectableRectangleState();
}

class _SelectableRectangleState extends State<SelectableRectangle> {
  Offset _startOffset = Offset.zero;
  Offset _currentOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          _startOffset = details.localPosition;
          _currentOffset = details.localPosition;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _currentOffset = details.localPosition;
        });
      },
      child: CustomPaint(
        painter: RectanglePainter(startOffset: _startOffset, endOffset: _currentOffset),
        size: Size(200, 200),
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  final Offset startOffset;
  final Offset endOffset;

  RectanglePainter({required this.startOffset, required this.endOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromPoints(startOffset, endOffset);
    canvas.drawRect(rect, paint);

    final borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRect(rect, borderPaint);

    final textStyle = TextStyle(color: Colors.black, fontSize: 14.0);
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Selected Area: (${(endOffset.dx - startOffset.dx).toStringAsFixed(2)}, ${(endOffset.dy - startOffset.dy).toStringAsFixed(2)})',
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(10, size.height - 30));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}