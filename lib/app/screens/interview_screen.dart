import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:mockcrack/app/screens/results_screen.dart';
import 'package:mockcrack/services/api_service.dart';
import 'package:mockcrack/utils/colors.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:path_provider/path_provider.dart';

import '../../services/tts_stt_service.dart';

class InterviewScreen extends StatefulWidget {
  final List<String> questions;
  const InterviewScreen({super.key, required this.questions});

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  /// [timer] services
  late Timer _timer;
  Duration _elapsedTime = Duration.zero;

  /// [questions] services
  final int totalQuestions = 10;
  int currentQuestion = 1;
  List<int> scores = [];
  List<String> ans = [];
  List<Answer> answers = [];

  /// [camera] services
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  String? _cameraError;
  final AudioService _audioService = AudioService();
  final ApiService _service = ApiService();
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    _initializeCamera();

    _speakQuestion(); // speak up first [Question]
  }

  void _startListening() async {
    String result = await _audioService.speechToText();
    print(result);
    if (result.isNotEmpty) {
      final answer =
          await _evaluateAnswer(widget.questions[currentQuestion - 1], result);

      print(
          "Answer: {${answer.answer} , ${answer.score} , ${answer.accuracy}}");

      answers.add(answer);
      setState(() {
        ans.add(result); // Store the recognized text
        scores.add(answer.score);
        currentQuestion++;
        _speakQuestion();
      });
    }
  }

  void _speakQuestion() async => await _audioService.textToSpeech(
      "Question $currentQuestion: ${widget.questions[currentQuestion - 1]}");

  Future<Answer> _evaluateAnswer(String question, String answer) async =>
      await _service.evaluateScore(question, answer);

  Future<void> _initializeCamera() async {
    try {
      final status = await ph.Permission.camera.request();
      if (!status.isGranted) {
        setState(() {
          _cameraError = 'Camera permission denied';
        });
        return;
      }

      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _cameraError = 'No cameras found';
        });
        return;
      }

      // Use front camera (index 1 usually)
      _cameraController = CameraController(
        cameras[1], // Changed from cameras.first to cameras[1] for front camera
        ResolutionPreset.medium,
        enableAudio: true, // Changed to true to enable audio recording
      );

      try {
        await _cameraController!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
            _cameraError = null;
          });
        }
      } catch (e) {
        setState(() {
          _cameraError = 'Error initializing camera: $e';
        });
        debugPrint('Error initializing camera: $e');
      }
    } catch (e) {
      setState(() {
        _cameraError = 'Error accessing camera: $e';
      });
      debugPrint('Error accessing camera: $e');
    }
  }

  Future<void> _startRecording() async {
    if (_cameraController == null || !_isCameraInitialized) return;

    try {
      await _cameraController!.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController == null || !_isCameraInitialized) return;

    try {
      final XFile file = await _cameraController!.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });
      debugPrint('Video saved to: ${file.path}');
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += const Duration(seconds: 1);
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Interview title and Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Interview',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      _formatDuration(_elapsedTime),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Camera Feed Container
              Expanded(
                flex: 3,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: _isCameraInitialized && _cameraController != null
                            ? CameraPreview(_cameraController!)
                            : Center(
                                child: Text(
                                  _cameraError ?? 'Initializing camera...',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Question Chips
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(widget.questions.length, (index) {
                    return FilterChip(
                      label: Text('Q${index + 1}'),
                      selected: currentQuestion == index + 1,
                      onSelected: (_) {
                        setState(() {
                          currentQuestion = index + 1;
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Color(0xff062f29),
                      showCheckmark: false,
                      labelStyle: TextStyle(
                        color: currentQuestion == index + 1
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // Question Display
              // Center(
              //   child: Container(
              //     padding: const EdgeInsets.all(16),
              //     child: Text(
              //       'Q$currentQuestion: ${widget.questions[currentQuestion - 1]}',
              //       style: const TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),

              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // Stop listening and recording
                        if (_isRecording) {
                          await _stopRecording();
                        }

                        // If there is recognized text, store it in ans
                        if (currentQuestion < widget.questions.length) {
                          // Store the recognized text (if any)
                          String result = await _audioService.speechToText();

                          print(result);
                          if (result.isNotEmpty) {
                            setState(() {
                              ans.add(result); // Store the recognized text
                            });
                          }

                          currentQuestion++;
                          _speakQuestion(); // Speak the next question
                          // _startListening(); // Start listening for the next answer
                          _startRecording(); // Start recording for the next question
                        } else {
                          print("Interview Completed");
                        }
                      },
                      child: Container(
                        height: mq.height * 0.07,
                        margin: EdgeInsets.all(mq.height * 0.01),
                        decoration: BoxDecoration(
                          color: Color(0xff062f29),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.navigate_next_rounded,
                                color: Colors.white, size: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // record

                        _startListening();
                      },
                      child: Container(
                        height: mq.height * 0.07,
                        margin: EdgeInsets.all(mq.height * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          // borderRadius: BorderRadius.circular(16),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.mic, color: Colors.white, size: 30),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ResultsScreen(
                                questions: widget.questions,
                                answers: answers)));
                      },
                      child: Container(
                        height: mq.height * 0.07,
                        margin: EdgeInsets.all(mq.height * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "End",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.power_settings_new,
                                color: Colors.white, size: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
