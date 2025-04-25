import 'package:flutter/material.dart';
class CircleThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;
final Color thumbColor;
  const CircleThumbShape( {
    this.thumbRadius = 6.0,
    this.thumbColor=Colors.blue
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    bool? isPressed,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.white // White fill for the thumb's center
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = thumbColor // Border color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw filled circle (white background)
    canvas.drawCircle(center, thumbRadius, fillPaint);
    // Draw border circle
    canvas.drawCircle(center, thumbRadius, borderPaint);
  }
}