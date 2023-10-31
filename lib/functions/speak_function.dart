
import 'package:flutter_tts/flutter_tts.dart';
final FlutterTts flutterTts = FlutterTts();
speak(String text) async {
  await flutterTts.setLanguage("en-US");
  await flutterTts.setPitch(1); // 0.5 to 1.5
  await flutterTts.speak(text);
}

void stopSpeaking() async {
    await flutterTts.stop();
}
