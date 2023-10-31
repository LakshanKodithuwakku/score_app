import 'package:flutter/material.dart';

class CircleTextWidget extends StatelessWidget {
  final String text;
  final Color circleColor;
  final Color textColor;
  final double circleRadius;

  CircleTextWidget({
    required this.text,
    required this.circleColor,
    required this.textColor,
    required this.circleRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleRadius * 2,
      height: circleRadius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}