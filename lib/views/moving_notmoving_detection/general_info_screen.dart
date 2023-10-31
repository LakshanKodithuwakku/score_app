import 'dart:convert';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';


class GeneralInfoScreen extends StatefulWidget {
  const GeneralInfoScreen({Key? key}) : super(key: key);

  @override
  State<GeneralInfoScreen> createState() => _GeneralInfoScreenState();
}

class _GeneralInfoScreenState extends State<GeneralInfoScreen> {
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
        "question": "Relation to the child?",
        "options": ["Parent", "Teacher"]
      },
      {
        "question": "Child's age?",
        "options": ["Under 6 years", "Over 6 years"]
      },
      {
        "question": "Gender",
        "options": ["Male", "Female"]
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
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "“Need for movement” \n characteristic",
                                style: TextStyle(color: textBlue, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "General Information",
                                style: TextStyle(
                                    color: generalInfo_text, fontSize: 16),
                              ),
                            ),
                          ],
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
                        Text(" Question " + (index + 1).toString(),
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
          SizedBox(
            height: 10,
          ),
          CustomButton(
              onPressed: () {
               /* Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const MCQScreen(),
                  ),
                );*/
              },
              titel: 'Next',
              textColor: textWhite,
              buttonColor: backgroundBlue),
        ],
      ),
    );
  }
}
