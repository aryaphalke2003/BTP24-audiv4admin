import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

// The class that initializes the speech to text for entering the
// name of the student user. It listens until the user speaks
class SpeechApi {
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
  }) async {
    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => print('Error: $e'),
    );

    //  if text to speech functioning.
    if (isAvailable) {
      _speech.listen(
        onResult: (value) => onResult(value.recognizedWords),
        onDevice: true,
      );
    }

    return isAvailable;
  }
}
