import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../functions/functions.dart';
import '../../provider/provider.dart';
import '../../widgets/widgets.dart';
import '../views.dart';

class FinalResultScreen extends StatefulWidget {
  const FinalResultScreen({Key? key}) : super(key: key);

  @override
  State<FinalResultScreen> createState() => _FinalResultScreenState();
}

class _FinalResultScreenState extends State<FinalResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream_background,
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
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Thank you!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: textBlue,
                  ),
                ),
                Image.asset(
                  "assets/images/final.png",
                  width: 250,
                  height: 250,
                ),
                Text(
                  "Result:",
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
                  builder: ((context, responseProviderModel, child) => Text(
                            textAlign: TextAlign.center,
                            responseProviderModel.diagnose == "no"
                                ? "Low probability of having CVI"
                                : responseProviderModel.diagnose == "yes"
                                    ? "High probability of having CVI"
                                    : responseProviderModel.diagnose,
                            style: const TextStyle(
                              fontSize: 30,
                              color: textBlue,
                            ),
                          )
                      /*CircleTextWidget(
                        text: responseProviderModel.diagnose == "no"
                            ? "Low probability of having CVi"
                            : responseProviderModel.diagnose == "yes"
                                ? "High probability of having CVi"
                                : responseProviderModel.diagnose,
                        circleColor: backgroundBlue,
                        textColor: textWhite,
                        circleRadius: 50.0,
                      )*/
                      ),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButton(
                  onPressed: () {
                    stopSpeaking();
                    Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const CVIGuidanceScreen(),//scoreShow(),
                            ),
                          );
                  },
                  titel: 'More information',
                  textColor: textWhite,
                  fontSize: 20,
                  buttonColor: backgroundBlue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
