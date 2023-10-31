import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:score_app/views/visual_complexity/activity0.dart';
import 'package:score_app/views/visual_field_prefarance/first_screen.dart';
import '../../../controllers/visual_field_preferance/marks.dart';
import '../start_screen.dart';

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
class EndScreen extends StatefulWidget {
  final String userId;
  const EndScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _EndScreenState createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {

  Future<void> _sendDataToFirestore(int totalMarks) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('visual_field_preference').doc(widget.userId).collection('total_marks').doc(widget.userId).set({
        'Total Marks': totalMarks,
      });
      print('Total Marks added to Firestore: $totalMarks');
    } catch (e) {
      print('Error adding Total Marks to Firestore: $e');
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
    int TotalMarks = Provider.of<MarksProvider>(context).totalMarks;
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
                  Text('Marks for Quiz: $TotalMarks',
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
                      _sendDataToFirestore(TotalMarks);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Activity0(userId: userId)),
                      );
                    } ,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.teal,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0), // Adjust the value as needed
                      ),
                    ),
                    child: const Text("NEXT ACTIVITY",
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
