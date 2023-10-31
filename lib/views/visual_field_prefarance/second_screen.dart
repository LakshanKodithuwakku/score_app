import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:score_app/views/visual_field_prefarance/third_screen.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/visual_field_preferance/score.dart';


FlutterTts flutterTts = FlutterTts();

Future<void> speakInstructions(String message) async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setVolume(0.5);
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setPitch(1);
  await flutterTts.speak(message);
}

class SecondScreen extends StatefulWidget {
  final String userId;

  const SecondScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late Timer _timer;
  int _secondsElapsed = 0;

  Future<void> _sendDataToFirestore(int score, int reactionTime) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('visual_field_preference').doc(widget.userId).collection('2nd_screen').doc(widget.userId).set({
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
            onTap: () {
              speakInstructions("Touch the red area.");
              // Stop the timer when the red area is touched
              _timer.cancel();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThirdScreen(userId: userId)),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                //ScoreManager.incrementScore();
                speakInstructions("Touch the red area.");

                int score = calculateScore(_secondsElapsed);
                int reactionTime = _secondsElapsed;

                // Send data to Firestore
                _sendDataToFirestore(score, reactionTime);
                Provider.of<ScoreProvider>(context, listen: false).updateTotalScore(score);
                // Stop the timer when the red area is touched
                _timer.cancel();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdScreen(userId: userId)),
                );
              },
              child: SizedBox(
                height: screenSize.height * 0.2, // 10% of the screen height
                width: screenSize.width, // Full screen width
                child: CustomPaint(
                  painter: OpenPainter(),
                ),
              ),
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
