import 'package:http/http.dart' as http;

Future<double> sendToModel (double activityScore, int marks, int timeScore) async {
  final url = 'http://192.168.8.100:5000/api/score';
  final response = await http.post(
    Uri.parse(url),
    body: {
      'totalActivityScore' : activityScore.toString(),
      'totalMarks' : marks.toString(),
      'totalTimeScore' : timeScore.toString(),
    },
  );

  if (response.statusCode == 200) {
    //Parse and return the model's prediction
    double prediction = double.parse(response.body);
    return prediction;
  } else {
    throw Exception('Failed to send data to the model');
  }
}



























// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// /*void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Results',
//       theme: ThemeData(
//         primarySwatch: Colors.yellow,
//       ),
//       home: ApiClient(finalScore: 0, timeScore: 0, userId: ''),
//     );
//   }/
// }*/
//
// class ApiClient extends StatefulWidget {
//   final int finalScore;
//   final int timeScore;
//   final String userId;
//
//   ApiClient({required this.finalScore, required this.timeScore, required this.userId});
//
//   @override
//   _ApiClientState createState() => _ApiClientState();
// }
//
// class _ApiClientState extends State<ApiClient> {
//   String analysisResult = '';
//
//   void analyzeScore(BuildContext context) async {
//     print('Final Score: ${widget.finalScore}');
//     String result = await sendScoreToAPI(widget.finalScore, widget.timeScore, analysisResult);
//     setState(() {
//       analysisResult = result;
//     });
//     // ... Remaining code for displaying the analysis result.
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ... Your existing Flutter UI code.
//     );
//   }
// }
//
// Future<String> sendScoreToAPI(int totalScore, int timeScore, String userId) async {
//   final url = Uri.parse('http://192.168.8.100:5000/api/score');
//   final headers = {'Content-Type': 'application/json'};
//   final body = jsonEncode({'total_score': totalActivityScore, 'time_score': timeTimeScore, 'user_id': userId});
//
//   try {
//     final response = await http.post(url, headers: headers, body: body);
//
//     if (response.statusCode == 200) {
//       final result = jsonDecode(response.body);
//       String prediction = result['prediction'];
//       return prediction;
//     } else {
//       print('Request failed with status code: ${response.statusCode}');
//       return 'Error: API request failed';
//     }
//   } catch (e) {
//     print('API request failed: $e');
//     return 'Error: $e';
//   }
// }