import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../../controllers/visual_complexity/VC_score.dart';
import 'activity2.dart';
import 'activity3.dart';

FlutterTts flutterTts = FlutterTts();

Future<void> speakInstructions(String message) async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setVolume(0.5);
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setPitch(1);
  await flutterTts.speak(message);
}

class Activity2 extends StatefulWidget {
  final String userId;
  const Activity2({Key? key, required this.userId}) : super(key: key);

  @override
  _Activity2State createState() => _Activity2State();
}

class _Activity2State extends State<Activity2> {
  late Timer _timer;
  int _secondsElapsed = 0;

  Future<void> _sendDataToFirestore(int score, int reactionTime) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('visual_complexity').doc(widget.userId).collection('activity2').doc(widget.userId).set({
        'score': score,
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
    // Start the timer when the screen is loaded
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  int calculateScore(int reactionTime) {
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

  @override
  void dispose() {
    // Dispose the timer to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String userId = widget.userId;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              speakInstructions("Touch the yellow fish.");

              // Stop the timer when the red area is touched
              _timer.cancel();

              // Navigate to the next screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Activity3(userId: userId)),
              );
            },
            child: Image.asset(
              'assets/VC_images/black_s.png',
              fit: BoxFit.cover,
              width: screenWidth*1.0,
              height: screenHeight*1.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  speakInstructions("Touch the yellow fish.");

                  int score = calculateScore(_secondsElapsed);
                  int reactionTime = _secondsElapsed;

                  // Send data to Firestore
                  _sendDataToFirestore(score, reactionTime);

                  // Stop the timer when the red area is touched
                  _timer.cancel();

                  Provider.of<VC_ScoreProvider>(context, listen: false).updateTotalScore(score);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Activity3(userId: userId)),
                  );
                },
                child: Image.asset("assets/VC_images/teddy_black.png",
                  height: 150.0,
                  width: 150.0,
                ),

              ),
              GestureDetector(
                onTap: () {
                  speakInstructions("Touch the yellow fish.");

                  // Stop the timer when the red area is touched
                  _timer.cancel();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Activity3(userId: userId)),
                  );
                },
                child: Image.asset(
                  "assets/VC_images/tweet_black.png",
                  height: 200.0,
                  width: 100.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


