import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../views/views.dart';

class UserService {
  Future<void> createUser(/*{
   required String name,
   required int age,
   required String gender,
  }*/) async {
    final docUser = FirebaseFirestore.instance.collection('object_move').doc();
    final user = User(
     // name: name,
     // age: age,
     // gender: gender,
      ac1_marks: 10 - gl_mark_1.round(),
      ac2_marks: 10 - gl_mark_2.round(),
      ac1_clicked_time: clicked_time_ac1,
      ac2_clicked_time: clicked_time_ac2,
      quiz_mark: quiz_mark
    );
    final json = user.toJson();
    await docUser.set(json);
    doc_id = docUser.id;
  }
}
