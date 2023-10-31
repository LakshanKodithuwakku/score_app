import 'package:flutter/material.dart';

class CP_TimeScoreProvider extends ChangeNotifier {
  int totalTimeScore = 0;


  int get TotalTimeScore => totalTimeScore;

  void updateTotalScore(int score) {
    totalTimeScore += score;
    notifyListeners();
  }
}