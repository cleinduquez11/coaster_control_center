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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Base size scaled from screen width (smaller)
    double baseWidth = screenWidth * 0.15; // 10% of screen width
    double baseHeight = screenWidth * 0.025; // 2.5% of screen width

    // Set min/max bounds to avoid extremes
    baseWidth = baseWidth.clamp(120.0, 200.0);
    baseHeight = baseHeight.clamp(35.0, 60.0);

    // Adjust size slightly on hover
    final width = _isHovered ? baseWidth + 10 : baseWidth;
    final height = _isHovered ? baseHeight + 5 : baseHeight;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.primaryColor ?? Colors.blue.shade900,
              widget.hoverColor ?? Colors.blue.shade400,
            ],
          ),
        ),
        child: ElevatedButton.icon(
          onPressed: widget.onPressed,
          icon: widget.icon,
          label: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 13,
              wordSpacing: 1.2,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 16),
            ),
          ),
        ),
      ),
    );
  }
}
