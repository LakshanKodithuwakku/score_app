import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../functions/functions.dart';
import '../../provider/provider.dart';
import '../../widgets/widgets.dart';
import '../views.dart';

class ActivityTwoComplete extends StatefulWidget {
  const ActivityTwoComplete({Key? key}) : super(key: key);

  @override
  State<ActivityTwoComplete> createState() => _ActivityTwoCompleteState();
}

class _ActivityTwoCompleteState extends State<ActivityTwoComplete> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speak(
        "Time's up! Well done! You've completed the activity two. Great job finding the static gray car!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundYellow,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/logo_img_2.png",
                    width: 160,
                    height: 80,
                  ),
                ),
                Text(
                  "Moving Car",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: textBlue,
                  ),
                ),
                Image.asset(
                  "assets/images/car_brown.png",
                  width: 250,
                  height: 250,
                ),
                Text(
                  "Activity 2",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: textBlue,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CircleTextWidget(
                  text: (10 - gl_mark_1.round()).toString(),
                  circleColor: backgroundBlue,
                  textColor: backgroundYellow,
                  circleRadius: 40.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Completed.",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: textBlue,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<ResponseProvider>(
                  builder: ((context, responseProviderModel, child) =>
                      CustomButton(
                        onPressed: () {
                          stopSpeaking();
                          responseProviderModel.postData();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => scoreShow(),
                            ),
                          );
                        },
                        titel: 'Result',
                        textColor: textBlue,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

