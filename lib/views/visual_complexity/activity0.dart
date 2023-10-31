import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'activity1.dart';

FlutterTts flutterTts = FlutterTts();

Future<void> speakInstructions(String message) async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setVolume(0.5);
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setPitch(1);
  await flutterTts.speak(message);
}

class Activity0 extends StatelessWidget {
  final String userId;
  const Activity0({Key? key, required this.userId}) : super(key: key);

  Future<void> _sendUserIdToFirestore(String userId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('visual_complexity').doc(userId).set({
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('User ID added to Firestore: $userId');
    } catch (e) {
      print('Error adding user ID to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrounds/start.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                speakInstructions("Touch the red teddy");
                await _sendUserIdToFirestore(userId);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Activity1(userId: userId)),
                );
              },

              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal,
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0), // Adjust the value as needed
                ),
              ),
              child: const Text('Start Activity',
                style:TextStyle(fontSize: 30) ,),
            ),
          ),
        ),
      ),
    );
  }
}

