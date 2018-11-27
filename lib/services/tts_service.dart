


// Future _speak() async{
//     var result = await flutterTts.speak("Hello World");
//     if (result == 1) setState(() => ttsState = TtsState.playing);
// }

// Future _stop() async{
//     var result = await flutterTts.stop();
//     if (result == 1) setState(() => ttsState = TtsState.stopped);
// }

// List<dynamic> languages = await flutterTts.getLanguages;

// await flutterTts.setLanguage("en-US");

// await flutterTts.setSpeechRate(1.0);

// await flutterTts.setVolume(1.0);

// await flutterTts.setPitch(1.0);

// await flutterTts.isLanguageAvailable("en-US");

// flutterTts.setStartHandler(() {
//   setState(() {
//     ttsState = TtsState.playing;
//   });
// });

// flutterTts.setCompletionHandler(() {
//   setState(() {
//     ttsState = TtsState.stopped;
//   });
// });

// flutterTts.setErrorHandler((msg) {
//   setState(() {
//     ttsState = TtsState.stopped;
//   });
// });