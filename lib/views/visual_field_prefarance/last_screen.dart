import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/visual_field_preferance/score.dart';
import 'Quiz/Q1.dart';
import 'model.dart';
//
// class LastScreen extends StatelessWidget {
//   const LastScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.yellow,
//         appBar: AppBar(
//           title: const Text('Score'),
//           backgroundColor: Colors.deepPurple,
//         ),
//         body:Center(
//
//           child: Text('Score: ${ScoreManager.score}',
//             style: const TextStyle(
//               fontSize: 26,
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class LastScreen extends StatefulWidget {
  final String userId;
  const LastScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _LastScreenState createState() => _LastScreenState();
}

class _LastScreenState extends State<LastScreen> {

  Future<void> _sendDataToFirestore(int totalScore) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('visual_field_preference').doc(widget.userId).collection('total_score').doc(widget.userId).set({
        'Total Score': totalScore,
      });
      print('Total Score added to Firestore: $totalScore');
    } catch (e) {
      print('Error adding Total score to Firestore: $e');
    }
  }
  //String predictedCondition = 'Loading...'; // Default message while loading.

  /*@override
  void initState() {
    super.initState();

    // Call the function to get the predicted condition
    getPredictedCondition(userScore).then((result) {
      setState(() {
        predictedCondition = result;
      });
    }).catchError((error) {
      setState(() {
        predictedCondition = 'Error: $error';
      });
    });
  }*/

  //int total = ScoreProvider().getTotalScore();

  @override
  Widget build(BuildContext context) {
    int TotalScore = Provider.of<ScoreProvider>(context).totalScore;
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
                /*Text('                 Predicted Condition: $predictedCondition',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
                ElevatedButton(
                  onPressed:(){
                    // Send data to Firestore
                    _sendDataToFirestore(TotalScore);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Question1Screen(userId: userId)),
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
                    style:TextStyle(fontSize: 20) ,),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
