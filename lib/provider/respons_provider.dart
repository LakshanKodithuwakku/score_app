import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../views/views.dart';


class ResponseProvider extends ChangeNotifier{
  String diagnose = "";

  Future<void> postData() async {
    final url = Uri.parse(api+'/submit_data');

    final data = {
      "Activity 1 - Marks": [10 - gl_mark_1.round()],
      "Activity 2 - Marks": [10 - gl_mark_2.round()]
    };

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print('POST request successful');
      print(response.body);
      // Parse the JSON response
      var responseJson = json.decode(response.body);

      // Access the "no" value
      var messageList = responseJson['message'];
      var noValue = messageList[0];
      diagnose = noValue;
      print("Value of 'no': $noValue");
      db_updade();
    } else {
      print('Failed to send POST request');
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    notifyListeners();
  }

  void db_updade(){
    final docUser = FirebaseFirestore.instance
        .collection('object_move')
        .doc(doc_id);
    /// Update specification fields
    docUser.update({
      'result':diagnose == "no" ? "Low probability of having CVI" : diagnose == "yes" ? "High probability of having CVI" : diagnose
    });
  }
}