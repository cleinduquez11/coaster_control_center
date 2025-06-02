import 'dart:math';

import 'package:flutter/material.dart';
class MenuButton extends StatefulWidget {
  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _isOpen = false;
  final List<IconData> _menuItems = [
    Icons.add,
    Icons.remove,
    Icons.edit,
    Icons.share,
    Icons.delete,
    Icons.archive,
    Icons.more_horiz,
  ];

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 250, // Position the button in the bottom right   
          right: 250,   
          child: FloatingActionButton( 
            onPressed: _toggleMenu,
            child: Icon(_isOpen ? Icons.close : Icons.menu),
          ),
        ),
        if (_isOpen)
          Positioned(
            bottom: 400,  // Adjust the positioning of the menu based on your preference
            right: 400,
            child: _buildMenu(),
          ),
      ],
    );
  }

  Widget _buildMenu() {
    final double buttonSize = 56.0; // Adjust based on your FAB size

    return Container(
      child: Wrap(
        children: _menuItems.asMap().entries.map((entry) {
          final double angle = (entry.key* 0.05* pi) / (_menuItems.length - 1);
          final double x = buttonSize * cos(angle) + buttonSize;
          final double y = buttonSize * sin(angle) + buttonSize;

          return Transform.translate(
            offset: Offset(x, y),
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                // Handle menu item tap
                print('Tapped item: ${entry.value}');
                _toggleMenu();
              },
              child: Icon(entry.value),
            ),
          );
        }).toList(),
      ),
    );
  }
}