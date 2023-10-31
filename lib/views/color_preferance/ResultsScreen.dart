import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/color_preferance/CP_Activity_Score.dart';
import '../../controllers/color_preferance/CP_Time_Score.dart';
import 'package:score_app/views/color_preferance/Quiz/CP_Q1.dart';
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
class ResultsScreen extends StatefulWidget {
  final String userId;
  const ResultsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {

  Future<void> _sendDataToFirestore(int totalTimeScore, double
  totalActivityScore) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('color_preferance').doc(widget.userId).collection('Total Scores').doc(widget.userId).set({
        'Total Time Score': totalTimeScore,
        'Total Activity Score' : totalActivityScore,
      });
      print('Total Time Score added to Firestore: $totalTimeScore');
      print('Total Activity Score added to Firestore: $totalActivityScore');
    } catch (e) {
      print('Error adding Total scores to Firestore: $e');
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
    int TotalTimeScore = Provider.of<CP_TimeScoreProvider>(context).totalTimeScore;
    double TotalActivityScore = Provider.of<CP_ActivityScoreProvider>(context).totalActivityScore;

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
                  Text('Your Activity Score: $TotalActivityScore',
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('Your Time Score: $TotalTimeScore',
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                      _sendDataToFirestore(TotalTimeScore, TotalActivityScore);

                      //Navigating to quiz
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
                    child: const Text('END',
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
