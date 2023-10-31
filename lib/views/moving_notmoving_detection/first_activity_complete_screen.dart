import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../functions/functions.dart';
import '../../widgets/widgets.dart';
import '../views.dart';

class ActivityOneComplete extends StatefulWidget {
  const ActivityOneComplete({Key? key}) : super(key: key);

  @override
  State<ActivityOneComplete> createState() => _ActivityOneCompleteState();
}

class _ActivityOneCompleteState extends State<ActivityOneComplete> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speak("Time's up! Well done" +gl_name+"! You've completed the 'Ride' activity. Great job spotting and clicking the moving gray car!");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
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
                    "assets/images/logo_img.png",
                    width: 160,
                    height: 80,
                  ),
                ),
                const Text("Moving Car", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: textWhite,
                ),),
                Image.asset(
                  "assets/images/car_brown.png",
                  width: 250,
                  height: 250,
                ),
                const Text("Activity 1", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: textWhite,
                ),),
                SizedBox(height: 20,),
                CircleTextWidget(
                  text: (10 - gl_mark_1.round()).toString(),
                  circleColor: backgroundYellow,
                  textColor: textBlue,
                  circleRadius: 40.0,
                ),
                const SizedBox(height: 20,),
                const Text("Completed.", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: textWhite,
                ),),
                const SizedBox(height: 50,),
                CustomButton(onPressed: () {
                  stopSpeaking();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const SecondActStartScreen(),
                    ),
                  );
                }, titel: 'Next', textColor: textBlue,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
