import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:score_app/controllers/color_preferance/CP_Activity_Score.dart';
import '../../controllers/color_preferance/CP_Time_Score.dart';
import '/controllers/color_preferance/score_manager.dart';
import 'step2.dart';

class Step1 extends StatefulWidget {
  final String userId;
  Step1({required this.userId});

  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  final FlutterTts flutterTts = FlutterTts();
  late Timer _timer;
  int _secondsElapsed = 0;
  /*late Stopwatch stepTimer;
  Color? selectedColor;*/

  Future<void> _sendDataToFirestore(int score, int reactionTime, double color_score, String color_name) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('color_preferance').doc(widget.userId).collection('step1').doc(widget.userId).set({
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
    await flutterTts.speak('Choose red color');
  }

  double checkAnswer(Color selectedColor) {
    //int color_score = 0;
    if (selectedColor == Colors.red) {
      return 1;
    } else {
      return 0.2;
    }
  }

  String getColorName(Color color) {
    if (color == Colors.red) {
      return 'red';
    } else if (color == Colors.green) {
      return 'green';
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
        title: Text('Choose Red Colour'),
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
                        double color_score = checkAnswer(Colors.red);
                        String color_name = getColorName(Colors.red);

                        flutterTts.speak('Correct');

                        // Send data to Firestore
                        _sendDataToFirestore(score, reactionTime, color_score, color_name);

                        // Stop the timer when the red area is touched
                        _timer.cancel();

                        Provider.of<CP_ActivityScoreProvider>(context, listen: false).updateTotalScore(color_score);
                        Provider.of<CP_TimeScoreProvider>(context, listen: false).updateTotalScore(score);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Step2(userId: userId)),
                        );
                      },
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        int score = calculateTimeScore(_secondsElapsed);
                        int reactionTime = _secondsElapsed;
                        double color_score = checkAnswer(Colors.green);
                        String color_name = getColorName(Colors.green);

                        flutterTts.speak('Wrong');

                        // Send data to Firestore
                        _sendDataToFirestore(score, reactionTime, color_score, color_name);

                        // Stop the timer when the red area is touched
                        _timer.cancel();

                        Provider.of<CP_ActivityScoreProvider>(context, listen: false).updateTotalScore(color_score);
                        Provider.of<CP_TimeScoreProvider>(context, listen: false).updateTotalScore(score);

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Step2(userId: userId)),
                        );
                      },
                      child: Container(
                        color: Colors.green,
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
