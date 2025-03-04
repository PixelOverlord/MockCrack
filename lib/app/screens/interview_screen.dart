import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:mockcrack/app/screens/results_screen.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class InterviewScreen extends StatefulWidget {
  const InterviewScreen({super.key});

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  late Timer _timer;
  Duration _elapsedTime = Duration.zero;
  final int totalQuestions = 10;
  int currentQuestion = 1;
  bool isPaused = false;

  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  String? _cameraError;

  @override
  void initState() {
    super.initState();
    startTimer();
    _initializeCamera();
  }

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

      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
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

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        setState(() {
          _elapsedTime += const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
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
                child: Container(
                  width: double.infinity,
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
              const SizedBox(height: 20),

              // Question Chips
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(totalQuestions, (index) {
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
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Q$currentQuestion: Sample question text goes here',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (currentQuestion < totalQuestions) {
                          currentQuestion++;
                        } else {
                          currentQuestion = 1;
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
                        // stop timer

                        setState(() {
                          if (!isPaused) {
                            isPaused = true;
                          } else {
                            isPaused = false;
                          }
                        });
                      },
                      child: Container(
                        height: mq.height * 0.07,
                        margin: EdgeInsets.all(mq.height * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isPaused ? "Resume" : "Pause",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(isPaused ? Icons.play_arrow : Icons.pause,
                                color: Colors.white, size: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => ResultsScreen()));
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
