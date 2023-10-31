import 'dart:async';
import 'package:score_app/functions/speak_function.dart';

middletimeCommand() {
  Timer(
      Duration(seconds: 20),
          () {
        speak("Remember, the gray car will be constantly moving, so stay sharp and keep your eyes on it!");
      });
}