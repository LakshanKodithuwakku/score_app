import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:score_app/widgets/widgets.dart';

import '../../constants/constants.dart';
import '../../models/models.dart';
import '../views.dart';

class MCQScreen extends StatefulWidget {
  const MCQScreen({Key? key}) : super(key: key);

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  String? selectedGender;
  List<MCQ> mcqs = []; // This list will store your MCQ data
  List<int?> selectedAnswers = []; // List to store selected answers
  late double height;
  late double width;

  @override
  void initState() {
    super.initState();
    // Parse the JSON data and populate the mcqs list
    // Define your JSON data as a string here
    String jsonData = '''
    [
      {
        "question": "Has difficulties following moving objects?",
        "options": ["Never", "Occasionally", "Frequently", "Always"]
      },
      {
        "question": "Has difficulties following moving people?",
        "options": ["Never", "Occasionally", "Frequently", "Always"]
      },
      {
        "question": "Has difficulties distinguishing familiar environment?",
        "options": ["Never", "Occasionally","Frequently","Always"]
      },
      {
        "question": "Does not recognise common pictures?",
        "options": ["Never", "Occasionally","Frequently","Always"]
      },
      {
        "question": "Has difficulties with reading the clock?",
        "options": ["Never", "Occasionally","Frequently","Always"]
      }
    ]
    ''';
    final parsedJson = json.decode(jsonData);
    for (var mcqJson in parsedJson) {
      mcqs.add(MCQ.fromJson(mcqJson));
      selectedAnswers
          .add(-1); // Initialize selected answers with -1 (no selection)
    }
  }

  void handleRadioValueChanged(String? value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    double statesbarheight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            child: Stack(
              children: [
                Container(
                  color: backgroundBlue,
                  height: 115,
                ),
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 8.0,
                            top: statesbarheight,
                            right: 8.0,
                            bottom: 8.0),
                        child: Container(
                          child: Image.asset(
                            "assets/images/logo_img.png",
                            width: 160,
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Container(
                        height: 100,
                        width: width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: border_mcq,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Select the most suitable answer that \n applies to your child.",
                            style: TextStyle(color: textBlue, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              height: height - 286,
              child: ListView.builder(
                itemCount: mcqs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" Question " + (index + 4).toString(),
                            style: TextStyle(
                                color: generalInfo_text, fontSize: 16)),
                        Card(
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                color: question_border,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(mcqs[index].question),
                              ),
                              Column(
                                children: mcqs[index]
                                    .options
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final optionIndex = entry.key;
                                  final optionText = entry.value;

                                  return RadioListTile(
                                    title: Text(optionText),
                                    value: optionIndex,
                                    groupValue: selectedAnswers[index],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAnswers[index] =
                                            value; // Store the selected answer
                                        print(index.toString() +
                                            value!.toString());
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const StartScreen(),
                  ),
                );
              },
              titel: 'Submit',
              textColor: textBlue,
              buttonColor: backgroundYellow),
        ],
      ),
    );
  }
}
