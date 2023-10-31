import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../api/color_preferance/api_client.dart';
import '../../../controllers/color_preferance/CP_Activity_Score.dart';
import '../../../controllers/color_preferance/CP_Quiz_Score.dart';
import '../../../controllers/color_preferance/CP_Time_Score.dart';
import 'CP_quiz_end.dart';

class Question6Screen extends StatefulWidget {
  final String userId;
  const Question6Screen({Key? key, required this.userId}) : super(key: key);
  @override
  _Question6ScreenState createState() => _Question6ScreenState();
}

class _Question6ScreenState extends State<Question6Screen> {
  String selectedAnswer = '';

  Future<void> _sendDataToFirestore(int marks) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('color_preferance').doc(widget.userId).collection('Q6_marks').doc(widget.userId).set({
        'Question 06': marks,
      });
      print('Question 06 mark added to Firestore: $marks');
    } catch (e) {
      print('Error adding Question 06 mark to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String userId = widget.userId;
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text('Color Preference',
        ),
        backgroundColor: Colors.deepPurple, // Set the background color here
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Does the child have favorite toys that are always a certain color?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              title: Text('Never'),
              value: 'Never',
              groupValue: selectedAnswer,
              onChanged: (value) {
                setState(() {
                  selectedAnswer = value.toString();
                });
              },
              activeColor: Colors.deepPurple, // Color of the selected radio button
              selectedTileColor: Colors.deepPurple.withOpacity(0.1), // Background color when selected
            ),
            RadioListTile(
              title: Text('Occasionally'),
              value: 'Occasionally',
              groupValue: selectedAnswer,
              onChanged: (value) {
                setState(() {
                  selectedAnswer = value.toString();
                });
              },
              activeColor: Colors.deepPurple, // Color of the selected radio button
              selectedTileColor: Colors.deepPurple.withOpacity(0.1), // Background color when selected
            ),
            RadioListTile(
              title: Text('Frequently'),
              value: 'Frequently',
              groupValue: selectedAnswer,
              onChanged: (value) {
                setState(() {
                  selectedAnswer = value.toString();
                });
              },
              activeColor: Colors.deepPurple, // Color of the selected radio button
              selectedTileColor: Colors.deepPurple.withOpacity(0.1), // Background color when selected
            ),
            RadioListTile(
              title: Text('Always'),
              value: 'Always',
              groupValue: selectedAnswer,
              onChanged: (value) {
                setState(() {
                  selectedAnswer = value.toString();
                });
              },
              activeColor: Colors.deepPurple, // Color of the selected radio button
              selectedTileColor: Colors.deepPurple.withOpacity(0.1), // Background color when selected
            ),
            ElevatedButton(
              onPressed: () async {

                // Calculate marks based on the selected answer
                int marks;
                if (selectedAnswer == 'Never') {
                  marks = 1;
                } else if (selectedAnswer == 'Occasionally') {
                  marks = 2;
                } else if (selectedAnswer == 'Frequently') {
                  marks = 3;
                } else if (selectedAnswer == 'Always') {
                  marks = 4;
                } else {
                  marks = 0; // Handle other cases if necessary
                }

                // Send data to Firestore
                _sendDataToFirestore(marks);

                //update the CP_MarkProvider
                Provider.of<CP_MarksProvider>(context, listen: false).updateTotalMarks(marks);

                double totalActivityScore = CP_ActivityScoreProvider().totalActivityScore;
                int totalMarks = Provider.of<CP_MarksProvider>(context, listen: false).totalMarks;
                int totalTimeScore = CP_TimeScoreProvider().totalTimeScore;

                // Send data to the model via the API client
                try {
                double prediction = await sendToModel(totalActivityScore, totalMarks, totalTimeScore);
                print('Prediction: $prediction');
                } catch (e) {
                  // Handle any errors that occur during the API call.
                  print('Error sending data to the model: $e');
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EndScreen(userId: userId)),
                );

              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              ),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
