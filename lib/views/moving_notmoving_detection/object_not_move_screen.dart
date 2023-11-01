import 'dart:async';
import 'package:flutter/material.dart';
import '../../functions/functions.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';
import '../views.dart';
import 'user_data_form_screen.dart';

class ObjectNotMoveScreen extends StatefulWidget {
  const ObjectNotMoveScreen({Key? key}) : super(key: key);

  @override
  State<ObjectNotMoveScreen> createState() => _ObjectNotMoveScreenState();
}

class _ObjectNotMoveScreenState extends State<ObjectNotMoveScreen> {
  late double width;
  late double height;
  final UserService _userService = UserService();
  bool isNotClicked = true;

  middletimeCommand() {
    Timer(Duration(seconds: 10), () {
      if (isNotClicked == true) {
        speak(
            "You're doing great! Keep looking for the gray car that is not moving. Stay focused!");
      }
    });
  }

  autonavigation() {
    Timer(Duration(seconds: 21), () async {
      stopSpeaking();
      if (isNotClicked == true) {
        /*_userService.createUser(
          //  name: gl_name, age: gl_age ?? 0, gender: gl_gender ?? ""
        );*/
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ActivityTwoComplete()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speak(
        "You need to click on the gray car as quickly as you can. You have 20 seconds to complete this challenge.");
    middletimeCommand();
    autonavigation();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final startTime = DateTime.now();

    return Scaffold(
      appBar: BaseAppBar(),
      body: Stack(
        children: [
          Image.asset("assets/images/background.png",
              width: width, fit: BoxFit.fill),
          Positioned(
            top: height / 3.6,
            left: 100,
            child: InkWell(
              onTap: () {
                setState(() {
                  isNotClicked = false;
                });
                stopSpeaking();
                final endTime = DateTime.now();
                clicked_time_ac2 = endTime.difference(startTime).inSeconds;
                gl_mark_2 = (clicked_time_ac2! / 21) * 10;
                print('Time duration: ${clicked_time_ac2}s');

                /*_userService.createUser(
                  //  name: gl_name, age: gl_age ?? 0, gender: gl_gender ?? ""
                );*/
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivityTwoComplete()));
              },
              child: Container(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    "assets/images/car.png",
                    width: width,
                  )),
            ),
          ),
          ProgressIndicatorWidget(),
        ],
      ),
    );
  }
}
