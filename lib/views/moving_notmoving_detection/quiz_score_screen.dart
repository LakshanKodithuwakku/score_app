import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../functions/functions.dart';
import '../../provider/provider.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';
import '../views.dart';

class QuizScoreScreen extends StatefulWidget {
  const QuizScoreScreen({Key? key}) : super(key: key);

  @override
  State<QuizScoreScreen> createState() => _QuizScoreScreenState();
}

class _QuizScoreScreenState extends State<QuizScoreScreen> {
  final UserService _userService = UserService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userService.createUser(
    );
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
               const SizedBox(height: 20,),
                Image.asset(
                  "assets/images/car_brown.png",
                  width: 250,
                  height: 250,
                ),
                const Text("Quiz", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: textWhite,
                ),),
                SizedBox(height: 20,),
                CircleTextWidget(
                  text: quiz_mark.toString(),
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
                Consumer<ResponseProvider>(
                  builder: ((context, responseProviderModel, child) =>
                      CustomButton(
                        onPressed: () {
                          stopSpeaking();
                          responseProviderModel.postData();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const FinalResultScreen(),//scoreShow(),
                            ),
                          );
                        },
                        titel: 'Next',
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
