import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:score_app/controllers/color_preferance/CP_Activity_Score.dart';
import 'package:score_app/controllers/color_preferance/CP_Time_Score.dart';
import 'package:score_app/views/views.dart';
import 'package:score_app/views/visual_complexity/activity0.dart';
import 'package:score_app/views/visual_field_prefarance/start_screen.dart';
import 'controllers/color_preferance/CP_Quiz_Score.dart';
import 'controllers/visual_complexity/VC_marks.dart';
import 'controllers/visual_complexity/VC_score.dart';
import 'controllers/visual_field_preferance/marks.dart';
import 'controllers/visual_field_preferance/score.dart';

import 'package:score_app/views/color_preferance/start.dart';

import 'provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCwWzdZdkh7f6QMVhQD2VF1btQ7GLGkfQk",
      appId: "1:80910024046:android:c2aaa4adace596598cd57f",
      messagingSenderId: "80910024046",
      projectId: "research-2023-f6ce5",
    ),
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight,]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ResponseProvider()),
        ChangeNotifierProvider(create: (context) => MarksProvider()),
        ChangeNotifierProvider(create: (context) => ScoreProvider()),
        ChangeNotifierProvider(create: (context) => VC_ScoreProvider()),
        ChangeNotifierProvider(create: (context) => VC_MarksProvider()),
        ChangeNotifierProvider(create: (context) => CP_ActivityScoreProvider()),
        ChangeNotifierProvider(create: (context) => CP_TimeScoreProvider()),
        ChangeNotifierProvider(create: (context) => CP_MarksProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartScreen(),
      ),
    );
  }
}
