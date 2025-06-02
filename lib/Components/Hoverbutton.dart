import 'package:flutter/material.dart';

class HoverElevatedButtonIcon extends StatefulWidget {
  final Icon icon;
  final String label;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final Color? primaryColor;
  final Color? hoverColor;
  final EdgeInsetsGeometry? padding;
  

  const HoverElevatedButtonIcon({
    Key? key,
    required this.icon,
    required this.label,
    this.onPressed,
    this.borderRadius,
    this.primaryColor,
    this.hoverColor,
    this.padding,
  }) : super(key: key);

  @override
  _HoverElevatedButtonIconState createState() =>
      _HoverElevatedButtonIconState();
}

class _HoverElevatedButtonIconState extends State<HoverElevatedButtonIcon> {
  double _buttonHeight = 50.0;
    double _buttonWidth = 240.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _buttonHeight = 70.0; // Increase height on hover
          _buttonWidth = 250;
        });
      },
      onExit: (_) {
        setState(() {
          _buttonHeight = 50.0; // Reset height on exit
           _buttonWidth = 240;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _buttonHeight,
        width: _buttonWidth,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
         gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.primaryColor?? Colors.blue.shade900, // Dark blue
              widget.hoverColor?? Colors.blue.shade400, // Lighter blue
            ],
          ),
        ),
        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          icon: widget.icon,
          label: Text(widget.label, style: TextStyle(
            wordSpacing: 1.5,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700
          ),),
          style: ElevatedButton.styleFrom(
            

            backgroundColor: Colors.transparent, // Remove default color
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
            elevation: 0, // Remove default shadow
            padding: EdgeInsets.zero, // Remove padding from ElevatedButton
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
            ),
          ),
        ),
      ),
    );
  }
}
