import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getPredictedCondition(double score) async {
  final apiUrl = 'http://192.168.0.100:5000/predict'; // Replace with your Flask API URL.
  final requestData = {'score': score};

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final String predictedCondition = data['predicted_condition'];
    return predictedCondition;
  } else {
    throw Exception('Failed to get predicted condition');
  }
}
