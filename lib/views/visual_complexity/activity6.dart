import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../../controllers/visual_complexity/VC_score.dart';
import 'activity7.dart';

FlutterTts flutterTts = FlutterTts();

Future<void> speakInstructions(String message) async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setVolume(0.5);
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setPitch(1);
  await flutterTts.speak(message);
}

class Activity6 extends StatefulWidget {
  final String userId;
  const Activity6({Key? key, required this.userId}) : super(key: key);

  @override
  _Activity6State createState() => _Activity6State();
}

class _Activity6State extends State<Activity6> {
  late Timer _timer;
  int _secondsElapsed = 0;

  Future<void> _sendDataToFirestore(int score, int reactionTime) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('visual_complexity').doc(widget.userId).collection('activity6').doc(widget.userId).set({
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
        children: [
          GestureDetector(
            onTap: () {
              speakInstructions("Touch the red teddy");

              // Stop the timer when the red area is touched
              _timer.cancel();

              // Navigate to the next screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Activity7(userId: userId)),
              );
            },
            child: Image.asset(
              'assets/VC_images/complex_s_1.jpg',
              fit: BoxFit.cover,
              width: screenWidth*1.0,
              height: screenHeight*1.0,
            ),
          ),

          GestureDetector(
            onTap: (){
              speakInstructions("Touch the red teddy");

              int score = calculateScore(_secondsElapsed);
              int reactionTime = _secondsElapsed;

              // Send data to Firestore
              _sendDataToFirestore(score, reactionTime);

              // Stop the timer when the red area is touched
              _timer.cancel();

              Provider.of<VC_ScoreProvider>(context, listen: false).updateTotalScore(score);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Activity7(userId: userId)),
              );
            },
            child: Container(
              child: Center(
                child: Image.asset(
                  'assets/VC_images/fish_c1.png',
                  height: 150.0,
                  width: 150.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


