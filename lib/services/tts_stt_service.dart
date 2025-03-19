import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AudioService {
  final FlutterTts _flutterTts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();

  /// Converts [text] to [audio] and plays it.
  Future<void> textToSpeech(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(text);
  }

  /// Converts spoken [audio] into [text].
  Future<String> speechToText() async {
    // Request permission before starting recognition
    await requestMicrophonePermission();

    if (!(await _speechToText.initialize())) {
      throw Exception("Speech recognition is not available.");
    }

    String recognizedText = "";
    await _speechToText.listen(onResult: (result) {
      recognizedText = result.recognizedWords;
    });

    // Wait for recognition to complete
    while (_speechToText.isListening) {
      await Future.delayed(Duration(milliseconds: 500));
    }

    await _speechToText.stop();
    return recognizedText.isNotEmpty ? recognizedText : "No speech detected.";
  }

  /// Requests microphone permission at runtime.
  Future<void> requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      throw Exception("Microphone permission denied.");
    }
  }
}
