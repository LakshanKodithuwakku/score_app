import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';
import '../../functions/functions.dart';
import '../../widgets/widgets.dart';
import '../views.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speak("Hello"+ gl_name +", Welcome to the 'Ride' activity! Are you ready to have some fun?"+
        "Great! In this activity, we're going to find and click on "
        "a specific object. Pay attention and get ready to spot a moving gray color car."
    +"Your mission is to keep an eye on the gray car as it moves and quickly click on it when you spot it.");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SingleChildScrollView(
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
                const SizedBox(height: 100,),
                CustomButton(onPressed: () {
                  stopSpeaking();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const ObjectMoveScreen(),
                    ),
                  );
                }, titel: 'Start',textColor: textBlue,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}