import 'package:flutter/material.dart';

class CP_ActivityScoreProvider extends ChangeNotifier {
  double totalActivityScore = 0;


  double get TotalActivityScore => totalActivityScore;

  void updateTotalScore(double color_score) {
    totalActivityScore += color_score;
    notifyListeners();
  }
}