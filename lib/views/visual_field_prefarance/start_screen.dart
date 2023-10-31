import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:uuid/uuid.dart';
import 'first_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:score_app/first_screen.dart';

FlutterTts flutterTts = FlutterTts();

Future<void> speakInstructions(String message) async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setVolume(0.5);
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setPitch(1);
  await flutterTts.speak(message);

}

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  String _generateUserId() {
    var uuid = Uuid();
    String userId = uuid.v4(); // Generate a new unique user ID
    _sendUserIdToFirestore(userId);
    return userId; // Generate a new unique user ID
  }

  Future<void> _sendUserIdToFirestore(String userId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('visual_field_preference').doc(userId).set({
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
    return MaterialApp(
      home: Scaffold(


        /*appBar: AppBar(
          title: const Text('Visual Field Preference',
          ),
          backgroundColor: Colors.deepPurple, // Set the background color here
        ),*/
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrounds/start.png"),
              fit: BoxFit.cover,
        ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed:(){
              speakInstructions("Welcome to the first screen. Touch the red area");
              String userId = _generateUserId(); // Generate a unique user ID
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstScreen(userId: userId)),

              );
            } ,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.teal,
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0), // Adjust the value as needed
              ),
            ),
            child: const Text("START",
              style:TextStyle(fontSize: 30) ,),
          ),
        ),

      ),
    ));
  }
}
