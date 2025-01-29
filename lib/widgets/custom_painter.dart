import 'package:flutter/material.dart';

import '../model/buttlet.dart';
import '../model/particle.dart';

import '../model/player_shooter.dart';

class CustomParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final AnimationController controller;
  final PlayerShooter player;
  final List<Bullet> bullets;

  CustomParticlePainter({
    required this.particles,
    required this.controller,
    required this.player,
    required this.bullets,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    ///
    particles.forEach((particle) => particle.draw(canvas, canvasSize));

    /// Draw bullets
    bullets.forEach((bullet) => bullet.draw(canvas, canvasSize));

    ///
    player.draw(canvas, canvasSize);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
