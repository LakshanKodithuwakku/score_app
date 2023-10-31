// import 'package:cloud_firestore/cloud_firestore.dart';
//
// Future<void> storeScoresInFirestore(
//     String userId,
//     Map<int, Map<int, dynamic>> chosenColors,
//     int totalScore,
//     int totalTimeScore,
//     Map<int, Map<int, int>> stepTimeTaken) async {
//   final userRef = FirebaseFirestore.instance.collection('color_preferance').doc(userId);
//
//   try {
//     // Store the chosen colors for all steps
//     await userRef.set({
//       'chosen_colors': chosenColors,
//       'overall_score': totalScore,
//       'time_score': totalTimeScore,
//       'step_time_taken': stepTimeTaken,
//     });
//
//     print('Data stored in Firestore successfully.');
//   } catch (e) {
//     print('Error storing data in Firestore: $e');
//   }
// }
