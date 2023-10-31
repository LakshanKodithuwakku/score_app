import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../constants/constants.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width,
      animation: true,
      lineHeight: 15.0,
      animationDuration: 20000,
      percent: 1,
      //center: Text("90.0%"),
      barRadius: const Radius.circular(16),
      progressColor: backgroundBlue,
    );
  }
}
