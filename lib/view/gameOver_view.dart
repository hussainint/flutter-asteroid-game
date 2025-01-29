import 'package:flutter/material.dart';

import 'game_view.dart';

class GameOver extends StatelessWidget {
  final String time;

  GameOver({
    required this.time,
  });

  // Format the time string into a user-friendly message
  String format(String _time) {
    List<String> n = _time.split(':');
    int min = int.parse(n[0]);
    int sec = int.parse(n[1]);
    String message = 'You lasted ';
    if (min != 0) {
      message += '$min minutes and ';
    }
    message += '$sec seconds';
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'GAME OVER',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              format(time), // Display the formatted time
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.25,
              height: 55,
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: () {
                // Navigate to the GameView when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => GameView(),
                  ),
                );
              },
              child: Text('Play Again'),
            )
          ],
        ),
      ),
    );
  }
}
