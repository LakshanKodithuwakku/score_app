import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../functions/functions.dart';
import '../../widgets/widgets.dart';
import '../views.dart';

class SecondActStartScreen extends StatefulWidget {
  const SecondActStartScreen({Key? key}) : super(key: key);

  @override
  State<SecondActStartScreen> createState() => _SecondActStartScreenState();
}

class _SecondActStartScreenState extends State<SecondActStartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speak("Welcome to the next activity! Get ready for some more fun."+
        "In this activity, we're going to search for a gray color car again, but this time it won't be moving. It will be a static."
        +"Are you ready to be a sharp observer? Let's start!");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundYellow,
      body: Center(
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
              const Text("Moving Car", style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: textBlue,
              ),),
              Image.asset(
                "assets/images/car_brown.png",
                width: 250,
                height: 250,
              ),
              const Text("Activity 2", style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: textBlue,
              ),),
              CustomButton(onPressed: () {
                stopSpeaking();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const ObjectNotMoveScreen(),
                  ),
                );
              }, titel: 'Next',textColor: textBlue,)
            ],
          ),
        ),
      ),
    );
  }
}
