import 'package:flutter/material.dart';

import 'view/gameStart_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asteroid App',
      home: GameStart(),
    );
  }
}
