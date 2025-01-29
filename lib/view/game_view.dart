import 'package:flutter/material.dart';

import '../viewmodel/game_viewmodel.dart';
import '../widgets/custom_painter.dart';
import '../widgets/livetimer.dart';
import 'gameOver_view.dart';

class GameView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameViewState();
  }
}

class _GameViewState extends State<GameView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  GameViewModel viewModel = GameViewModel();
  String total_time_played = '00:00';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1000),
      vsync: this,
    );
    _controller.addListener(() {
      viewModel.updateParticlePosition();
      viewModel.updateBulletPosition();
      if (!viewModel.isGameOver) {
        viewModel.checkCollisions(); // Detect collisions here

        setState(() {});
      } else {
        /// game over
        _controller.stop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => GameOver(
              time: total_time_played,
            ),
          ),
        );
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MouseRegion(
            onHover: (event) {
              viewModel.updatePlayerPosition(event.localPosition);
            },
            child: InkWell(
              onTap: () {
                print('tappeddddd');
                viewModel.shootBullet();
              },
              child: CustomPaint(
                foregroundPainter: CustomParticlePainter(
                  particles: viewModel.particles,
                  controller: _controller,
                  player: viewModel.player,
                  bullets: viewModel.bullets,
                ),
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ),
          LiveTimer(
            timer: (String timer) => total_time_played = timer,
          ),
        ],
      ),
    );
  }
}
