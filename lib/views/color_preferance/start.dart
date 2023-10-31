import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:score_app/views/color_preferance/step1.dart';
import 'package:uuid/uuid.dart';

import '../../controllers/color_preferance/score_manager.dart';

/*class start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CVI Color Activity',
      home: ColorActivityScreen(),
    );
  }
}*/

class ColorActivityScreen extends StatefulWidget {
  final String userId;
  const ColorActivityScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ColorActivityScreenState createState() => _ColorActivityScreenState();
}

class _ColorActivityScreenState extends State<ColorActivityScreen> {
  final FlutterTts flutterTts = FlutterTts();
  int score = 0;

  @override
  void initState() {
    super.initState();
    _speakInstruction();
  }

  Future<void> _speakInstruction() async {
    await flutterTts.speak('Please go to a dark place before doing the activity');
  }

  void _handleFinishActivity() async {
    //int overallScore = ScoreManager().calculateOverallScore();
    //String userId = Uuid().v4(); // Generate a unique user ID

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Result'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );

    //ScoreManager().stepScores.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SizedBox(
            width: 500,
            height: 500,
            child: Image.asset(
              'assets/color_preference/CVI_Logo.jpeg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'CVI Color Preference Activity',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              onPressed: () {
                String userId = Uuid().v4(); // Generate a unique user ID
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Step1(userId: userId)),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Let\'s Go!',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Image.asset(
              'assets/color_preference/teddy_bear2.png',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}