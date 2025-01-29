import 'dart:async';
import 'package:flutter/material.dart';

class LiveTimer extends StatefulWidget {
  final void Function(String time) timer;
  LiveTimer({required this.timer});
  @override
  _LiveTimerState createState() => _LiveTimerState();
}

class _LiveTimerState extends State<LiveTimer> {
  late Timer _timer;
  int _elapsedSeconds = 0; // Elapsed time in seconds

  @override
  void initState() {
    super.initState();

    // Start the count-up timer
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          // Increment the elapsed time in seconds
          _elapsedSeconds++;
        });
      },
    );
  }

  String _formatTime(int seconds) {
    // Calculate minutes and seconds from elapsed time
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    // Format the time as "mm:ss"
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = _formatTime(_elapsedSeconds);
    widget.timer(formattedTime);
    return Text(
      'Time: $formattedTime',
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
    );
  }
}
