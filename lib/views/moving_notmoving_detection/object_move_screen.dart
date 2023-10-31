import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../functions/functions.dart';
import '../../widgets/widgets.dart';
import '../views.dart';


class ObjectMoveScreen extends StatefulWidget {
  const ObjectMoveScreen({Key? key}) : super(key: key);

  @override
  State<ObjectMoveScreen> createState() => _ObjectMoveScreenState();
}

class _ObjectMoveScreenState extends State<ObjectMoveScreen> {
  late double width;
  late double height;
  final startTime = DateTime.now();
  bool isNotClicked = true;

  autonavigation() {
    Timer(const Duration(seconds: 21), () async {
      stopSpeaking();
      if(isNotClicked == true){
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ActivityOneComplete()));
      }
    });
  }

  middletimeCommand() {
    Timer(const Duration(seconds: 10), () {
      if (isNotClicked == true) {
        speak(
            "Remember, the gray car will be constantly moving, so stay sharp and keep your eyes on it!");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speak(
        "Ready? Set? Go! Start searching for the moving gray car. Click on it as soon as you see it.");
    middletimeCommand();
    autonavigation();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // Specify your tween
    final tween = MovieTween()
      ..tween('x', Tween(begin: 0.0, end: 0.0),
              duration: const Duration(seconds: 1))
          .thenTween('y', Tween(begin: -height / 9, end: height / 90),
              duration: const Duration(seconds: 5))
          .thenTween('x', Tween(begin: 0.0, end: 0.0),
              duration: const Duration(seconds: 1))
          .thenTween('y', Tween(begin: height / 90, end: -height / 9),
              duration: const Duration(seconds: 5));
    return Scaffold(
      appBar: BaseAppBar(),
      body: Stack(
        children: [
          Image.asset("assets/images/background.png",
              width: width, fit: BoxFit.fill),
          Positioned(
            top: 250,
            left: 100,
            child: LoopAnimationBuilder<Movie>(
              tween: tween, // Pass in tween
              duration: tween.duration, // Obtain duration
              builder: (context, value, child) {
                return Transform.translate(
                  // Get animated offset
                  offset: Offset(value.get('x'), value.get('y')),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isNotClicked = false;
                      });
                      stopSpeaking();
                      final endTime = DateTime.now();
                      clicked_time_ac1 = endTime.difference(startTime).inSeconds;
                      gl_mark_1 = (clicked_time_ac1! / 21) * 10;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ActivityOneComplete()));
                    },
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          "assets/images/car.png",
                          width: width,
                        )),
                  ),
                );
              },
            ),
          ),
          const ProgressIndicatorWidget(),
        ],
      ),
    );
  }
}
