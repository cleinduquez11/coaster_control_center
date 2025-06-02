import 'package:coaster_control_center/LandingPage.dart';
import 'package:flutter/material.dart';

class DragUpButtonOverlay extends StatefulWidget {
  @override
  _DragUpButtonOverlayState createState() => _DragUpButtonOverlayState();
}

class _DragUpButtonOverlayState extends State<DragUpButtonOverlay> {
  bool _showButtons = false;
  double _startY = 0.0;

  void _onPointerMove(PointerMoveEvent event) {
    if (_startY != 0.0 && event.position.dy < _startY - 50) {
      setState(() {
        _showButtons = true;
      });
    }
  }

  void _onPointerDown(PointerDownEvent event) {
    if (event.position.dy < 50) {
      _startY = event.position.dy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Listener(
          onPointerMove: _onPointerMove,
          onPointerDown: _onPointerDown,
          child:    LandingPage()
        ),
        if (_showButtons)
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Button 1"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Button 2"),
                ),

               
              ],
            ),
          ),
        
      ],
    );
  }
}

