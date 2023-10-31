import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../../controllers/visual_field_preferance/score.dart';
import 'last_screen.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

FlutterTts flutterTts = FlutterTts();

Future<void> speakInstructions(String message) async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setVolume(0.5);
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setPitch(1);
  await flutterTts.speak(message);
}

class NinthScreen extends StatefulWidget {
  final String userId;
  const NinthScreen({super.key, required this.userId});

  @override
  _NinthScreenState createState() => _NinthScreenState();
}

class _NinthScreenState extends State<NinthScreen> {
  late Timer _timer;
  int _secondsElapsed = 0;

  Future<void> _sendDataToFirestore(int score, int reactionTime) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('visual_field_preference').doc(widget.userId).collection('9th_screen').doc(widget.userId).set({
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
    final Size screenSize = MediaQuery.of(context).size;
    String userId = widget.userId;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () async {
              _timer.cancel();
              //int totalScore = await FirestoreService.getTotalScore(userId);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LastScreen(userId: userId)),
              );
            },

            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/black_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),

            ),
          ),

          GestureDetector(
            onTap: () async {
              int score = calculateScore(_secondsElapsed);
              int reactionTime = _secondsElapsed;

              // Send data to Firestore
              _sendDataToFirestore(score, reactionTime);

              Provider.of<ScoreProvider>(context, listen: false).updateTotalScore(score);

              // Stop the timer when the red area is touched
              _timer.cancel();
              // totalScore = await FirestoreService.getTotalScore(userId);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LastScreen(userId: userId)),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: screenSize.height * 0.25,
                  width: screenSize.width * 0.14,
                  child: CustomPaint(
                    painter: OpenPainter(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xFFF44336)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}