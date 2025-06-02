
import 'package:flutter/material.dart';


class SelectableRect extends StatefulWidget {
  @override
  _SelectableRectState createState() => _SelectableRectState();
}

class _SelectableRectState extends State<SelectableRect> {
  Offset _startOffset = Offset.zero;
  Offset _currentOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  GestureDetector(
      
        onPanStart: (details) {
          setState(() {
            _startOffset = details.localPosition;
            _currentOffset = details.localPosition;
            _printSides();
          });
        },
        onPanUpdate: (details) {
          setState(() {
            _currentOffset = details.localPosition;
            _printSides();
          });
        },
      
         
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(

              color: Colors.white.withOpacity(0.25),

            ),
            child: CustomPaint(
              
              painter: RectanglePainter(startOffset: _startOffset, endOffset: _currentOffset, ),
              size: Size(200, 200),
                  
                  
            ),
          ),
         
      );
   
  }

  void _printSides() {
    final topLeft = _startOffset;
    final bottomRight = _currentOffset;

    final top = topLeft.dy;
    final bottom = bottomRight.dy;
    final left = topLeft.dx;
    final right = bottomRight.dx;
 print('L: ${bottom - top}, W: ${right - left}');
    print('Top: $top, Bottom: $bottom, Left: $left, Right: $right');
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}