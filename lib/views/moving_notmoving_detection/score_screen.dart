import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../provider/provider.dart';
import '../../widgets/widgets.dart';

class scoreShow extends StatefulWidget {
  const scoreShow({Key? key}) : super(key: key);

  @override
  State<scoreShow> createState() => _scoreShowState();
}

class _scoreShowState extends State<scoreShow> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundYellow,
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
                    "assets/images/logo_img_2.png",
                    width: 160,
                    height: 80,
                  ),
                ),
                Image.asset(
                  "assets/images/car_brown.png",
                  width: 250,
                  height: 250,
                ),
                const Text(
                  "Having  probability of \"Need for movement \" CVI characteristic ?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<ResponseProvider>(
                  builder: ((context, responseProviderModel, child) =>
                      CircleTextWidget(
                        text: responseProviderModel.diagnose,
                        circleColor: backgroundBlue,
                        textColor: textWhite,
                        circleRadius: 50.0,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPressed: () {},
                  titel: 'See More',
                  textColor: textBlue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
