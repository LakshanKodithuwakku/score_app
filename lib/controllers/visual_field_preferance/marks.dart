import 'package:flutter/material.dart';

class MarksProvider extends ChangeNotifier {
  int totalMarks = 0;


  int get TotalMarks => totalMarks;

  void updateTotalMarks(int marks) {
    totalMarks += marks;
    notifyListeners();
  }
}