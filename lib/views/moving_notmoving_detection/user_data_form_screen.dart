import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score_app/views/moving_notmoving_detection/mcq_screen.dart';
import 'package:score_app/widgets/widgets.dart';
import '../../constants/constants.dart';
import '../views.dart';


class UserDataFormScreen extends StatefulWidget {
  const UserDataFormScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDataFormScreen> createState() => _UserDataFormScreenState();
}

late final String gl_name;
late final int? gl_age;
late final String gl_gender;


class _UserDataFormScreenState extends State<UserDataFormScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _apiController = TextEditingController();
  String? _nameErrorText;
  String? _ageErrorText;
  String? selectedGender;
  String? _genderErrorText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      _nameErrorText =
          _nameController.text.isEmpty ? 'This field is required.' : null;
      _ageErrorText =
          _ageController.text.isEmpty ? 'This field is required.' : null;
      _genderErrorText =
          selectedGender == null ? 'Please select a gender.' : null;
    });
  }

  void handleRadioValueChanged(String? value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundYellow,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 60, bottom: 16.0, left: 16, right: 16),
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/logo_img.png",
                  width: 160,
                  height: 80,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Fill Your Details",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: textWhite,
                ),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: _apiController,
                decoration: const InputDecoration(
                  labelText: 'Enter API',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  errorText: _nameErrorText,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Enter Age',
                  errorText: _ageErrorText,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black45,
                    width: 2.0,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select Your Gender"),
                    RadioListTile(
                      title: Text('Male'),
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: handleRadioValueChanged,
                    ),
                    RadioListTile(
                      title: Text('Female'),
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: handleRadioValueChanged,
                    ),
                    RadioListTile(
                      title: Text('Other'),
                      value: 'Other',
                      groupValue: selectedGender,
                      onChanged: handleRadioValueChanged,
                    ),
                  ],
                ),
              ),
              if (_nameErrorText != null ||
                  _ageErrorText != null ||
                  _genderErrorText != null)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Please fill in all required fields.',
                    style: TextStyle(
                      color: errorText,
                    ),
                  ),
                ),
              SizedBox(height: 50),
              CustomButton(
                onPressed: () {
                  _validateInput();
                  api = _apiController.text;
                  if (_nameErrorText == null &&
                      _ageErrorText == null &&
                      _genderErrorText == null) {
                    gl_name = _nameController.text;
                    gl_age = int.tryParse(_ageController.text);
                    gl_gender = selectedGender!;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const MCQScreen(), // Pass the data here
                      ),
                    );
                  }
                },
                titel: 'Next',
                textColor: textBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
