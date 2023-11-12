import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindcareflutterapp/models/questionaire.dart';
import 'package:mindcareflutterapp/services/responseServices.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  List<Questionaire> questions = [];
  int counter = 0;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
    counter = 0;
    ResponseServices().getQuestionaires().then((value) {
      questions = value;

      setState(() {
        loading = true;
      });
      print(value);
    }).onError((error, stackTrace) => null);
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 222, 251, 223), Colors.white])),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.refresh,
                    size: 30,
                  ),
                  const Spacer(),
                  Text(
                    '${counter + 1}/10',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  SwipeDetector(
                    onSwipeRight: (offset) =>
                        {_addSwipeLeft(SwipeDirection.right)},
                    onSwipeLeft: (offset) =>
                        {_addSwipeRight(SwipeDirection.left)},
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Text(
                                loading == true
                                    ? questions[counter].question
                                    : '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                             SizedBox(
                              child: Text(
                                  _speechToText.isListening
                                  ? '$_lastWords': _speechEnabled ? 'Tap the microphone to start listening...': 'Speech not available',
                                textAlign: TextAlign.center,
                                style: const  TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                  height: 0,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 40,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: _speechToText.isNotListening ? _startListening : _stopListening,
                        child: Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFFFD600),
                            shape: OvalBorder(),
                          ),
                          child: const Icon(
                            Icons.mic,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addSwipeRight(
    SwipeDirection direction,
  ) {
    if (counter < questions.length - 1) {
      setState(() {
        counter++;
      });
    }
  }

  void _addSwipeLeft(
    SwipeDirection direction,
  ) {
    if (counter > 0) {
      setState(() {
        counter--;
      });
    }
  }
}
