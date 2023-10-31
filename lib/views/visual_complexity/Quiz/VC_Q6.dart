import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/visual_complexity/VC_marks.dart';
import 'VC_Q2.dart';
import 'VC_Q7.dart';

class VC_Question6 extends StatefulWidget {
  final String userId;
  const VC_Question6({Key? key, required this.userId}) : super(key: key);
  @override
  _VC_Question6State createState() => _VC_Question6State();
}

class _VC_Question6State extends State<VC_Question6> {
  String selectedAnswer = '';

  Future<void> _sendDataToFirestore(int marks) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('visual_complexity').doc(widget.userId).collection('Q6_marks').doc(widget.userId).set({
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
        title: const Text('Visual Complexity',
        ),
        backgroundColor: Colors.deepPurple, // Set the background color here
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Does your child recognize people by their voice, clothes and posture rather than looking at their faces?',
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
                onPressed: () {
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

                  Provider.of<VC_MarksProvider>(context, listen: false).updateTotalMarks(marks);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VC_Question7(userId: userId)),
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
      ),
    );
  }
}
