import 'package:flutter/material.dart';

import 'game_view.dart';

class GameStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.25,
              height: 55,
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: () {
                // Navigate to the GameView when the button is pressed
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => GameView(),
                  ),
                );
              },
              child: Text('Start Game'),
            )
          ],
        ),
      ),
    );
  }
}
