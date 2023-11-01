import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String titel;
  final Color textColor;
  final Color? buttonColor;
  final double? height;
  final double? fontSize;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.titel,
      required this.textColor,
      this.buttonColor,
      this.height,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      //fillColor: Colors.green,
      //splashColor: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: buttonColor ?? backgroundWhite,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              titel,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize:fontSize ?? 35,
              ),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
