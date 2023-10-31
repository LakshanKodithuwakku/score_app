// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'firebase_utils.dart';
//
// class ScoreManager {
//   static ScoreManager _instance = ScoreManager._();
//
//   factory ScoreManager() => _instance;
//
//   ScoreManager._();
//
//   Map<int, int> stepScores = {};
//   Map<int, int> stepTimeScores = {};
//   Map<int, Map<int, String>?> chosenColors = {};
//   Map<int, Map<int, int>> stepTimeTaken = {};
//
//   void updateStepScore(int stepNumber, int score) {
//     stepScores[stepNumber] = score;
//   }
//
//   void updateStepTimeScore(int stepNumber, int timeScore) {
//     stepTimeScores[stepNumber] = timeScore;
//   }
//
//   void storeStepTimeTaken(int stepNumber, Map<int, int> timeTaken) {
//     stepTimeTaken[stepNumber] = timeTaken;
//   }
//
//   void storeStepChosenColors(int stepNumber, Map<int, String> colors) {
//     chosenColors[stepNumber] = colors;
//   }
//
//   int calculateOverallScore() {
//     int totalScore = stepScores.values.reduce((sum, score) => sum + score);
//     return totalScore;
//   }
//
//   int calculateOverallTimeScore() {
//     int totalTimeScore = stepTimeScores.values.reduce((sum, score) =>
//     sum + score);
//     return totalTimeScore;
//   }
//
//   void storeScoresInFirebase(String userId,
//       Map<int, Map<int, int>> stepTimeTaken) {
//     int totalScore = calculateOverallScore();
//     int totalTimeScore = calculateOverallTimeScore();
//
//     Map<int, Map<int, String>> stepChosenColors = {};
//     for (var step in chosenColors.keys) {
//       Map<int, String> colors = {};
//       for (var color in chosenColors[step]!.keys) {
//         colors[color] = chosenColors[step]![color]!;
//       }
//       stepChosenColors[step] = colors;
//     }
//     storeScoresInFirestore(
//         userId, stepChosenColors, totalScore, totalTimeScore, stepTimeTaken);
//   }
//
//   /*Future<Map<String, dynamic>> sendScoresToModel() async {
//     int totalScore = calculateOverallScore();
//     int totalTimeScore = calculateOverallTimeScore();
//
//     Map<int, String> flattenedColors = {};
//
//     for (var step in chosenColors.keys) {
//       for (var color in chosenColors[step]!.keys) {
//         flattenedColors[color] = chosenColors[step]![color]!;
//       }
//     }
//
//     final url = 'http://127.0.0.1:5000/api/score';
//
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode({
//           'total_score': totalScore,
//           'time_score': totalTimeScore,
//           'chosen_colors': flattenedColors,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final result = jsonDecode(response.body);
//         return result;
//       } else {
//         return {'error': 'API request failed'};
//       }
//     } catch (e) {
//       return {'error': e.toString()};
//     }
//
//
//     int getTotalScore() {
//       int total = 0;
//       for (var score in stepScores.values) {
//         total += score;
//       }
//       return total;
//     }
//
//     int getTotalTimeScore() {
//       int total = 0;
//       for (var score in stepTimeScores.values) {
//         total += score;
//       }
//       return total;
//     }
//   }*/
// }
