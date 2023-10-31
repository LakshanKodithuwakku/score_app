import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../../controllers/color_preferance/CP_Activity_Score.dart';
import '../../controllers/color_preferance/CP_Time_Score.dart';
import '/controllers/color_preferance/score_manager.dart';
import 'step3.dart';

class Step2 extends StatefulWidget {
  final String userId;
  Step2({required this.userId});

  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  final FlutterTts flutterTts = FlutterTts();
  late Timer _timer;
  int _secondsElapsed = 0;
  /*late Stopwatch stepTimer;
  Color? selectedColor;*/

  Future<void> _sendDataToFirestore(int score, int reactionTime, double color_score, String color_name) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('color_preferance').doc(widget.userId).collection('step2').doc(widget.userId).set({
        'time_score': score,
        'colorScore' : color_score,
        'colorName' : color_name,
        'reactionTime': _secondsElapsed,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Score added to Firestore: $score, Reaction Time: $reactionTime');
    } catch (e) {
      print('Error adding score to Firestore: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    playAudioInstruction();
    _startTimer();
    //stepTimer = Stopwatch()..start();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  int calculateTimeScore(int reactionTime) {
    if (reactionTime >= 1 && reactionTime <= 5) {
      return 1;
    } else if (reactionTime >= 6 && reactionTime <= 10) {
      return 2;
    } else if (reactionTime >= 11 && reactionTime <= 15) {
      return 3;
    } else if (reactionTime >= 16 && reactionTime <= 20) {
      return 4;
    } else {
      // Handle out-of-range reaction times if necessary
      return 5;
    }
  }

  void playAudioInstruction() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setVoice({
      'name': 'en-us-x-sfg#female_2-local',
    });
    await flutterTts.speak('Choose yellow color');
  }

  double checkAnswer(Color selectedColor) {
    //int color_score = 0;
    if (selectedColor == Colors.yellow) {
      return 0.8;
    } else {
      return 0.5;
      flutterTts.speak('Wrong');
    }
  }

  String getColorName(Color color) {
    if (color == Colors.yellow) {
      return 'yellow';
    } else if (color == Colors.lightBlueAccent) {
      return 'lightBlueAccent';
    } else {
      return 'unknown';
    }
  }

  @override
  void dispose() {
    // Dispose the timer to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userId = widget.userId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Choose Yellow Colour'),
      ),
      body: Container(
        color: Colors.deepPurpleAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        int score = calculateTimeScore(_secondsElapsed);
                        int reactionTime = _secondsElapsed;
                        double color_score = checkAnswer(Colors.lightBlueAccent);
                        String color_name = getColorName(Colors.lightBlueAccent);

                        // Send data to Firestore
                        _sendDataToFirestore(score, reactionTime, color_score, color_name);

                        // Stop the timer when the red area is touched
                        _timer.cancel();

                        flutterTts.speak('Wrong');

                        Provider.of<CP_ActivityScoreProvider>(context, listen: false).updateTotalScore(color_score);
                        Provider.of<CP_TimeScoreProvider>(context, listen: false).updateTotalScore(score);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Step3(userId: userId)),
                        );
                      },
                      child: Container(
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        int score = calculateTimeScore(_secondsElapsed);
                        int reactionTime = _secondsElapsed;
                        double color_score = checkAnswer(Colors.yellow);
                        String color_name = getColorName(Colors.yellow);

                        // Send data to Firestore
                        _sendDataToFirestore(score, reactionTime, color_score, color_name);

                        // Stop the timer when the red area is touched
                        _timer.cancel();

                        flutterTts.speak('Correct');

                        Provider.of<CP_ActivityScoreProvider>(context, listen: false).updateTotalScore(color_score);
                        Provider.of<CP_TimeScoreProvider>(context, listen: false).updateTotalScore(score);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Step3(userId: userId)),
                        );
                      },
                      child: Container(
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
