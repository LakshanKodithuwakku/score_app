import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/visual_complexity/VC_score.dart';
import 'Quiz/VC_Q1.dart';

class Activity10 extends StatefulWidget {
  final String userId;

  const Activity10({Key? key, required this.userId}) : super(key: key);

  @override
  _Activity10State createState() => _Activity10State();
}

class _Activity10State extends State<Activity10>{

  Future<void> _sendDataToFirestore(int totalScore) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('visual_complexity').doc(widget.userId).collection('total_score').doc(widget.userId).set({
        'Total Score': totalScore,
      });
      print('Total Score added to Firestore: $totalScore');
    } catch (e) {
      print('Error adding Total score to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int TotalScore = Provider.of<VC_ScoreProvider>(context).totalScore;
    String userId = widget.userId;
    return MaterialApp(
        home: Scaffold(
            body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgrounds/score.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  SizedBox(height: 10.0),
              Text('Your Score: $TotalScore',
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed:(){
                  // Send data to Firestore
                  _sendDataToFirestore(TotalScore);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VC_Question1(userId: userId)),
                  );
                } ,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.teal,
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0), // Adjust the value as needed
                  ),
                ),
                child: const Text('START THE QUIZ',
                  style:TextStyle(fontSize: 30) ,),
              ),
        ]),
            ),
          )
    ));}
}

