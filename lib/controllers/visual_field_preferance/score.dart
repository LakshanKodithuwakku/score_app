import 'package:flutter/material.dart';

class ScoreProvider extends ChangeNotifier {
  int totalScore = 0;


  int get TotalScore => totalScore;

  void updateTotalScore(int score) {
    totalScore += score;
    notifyListeners();
  }
}