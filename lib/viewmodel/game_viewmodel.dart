import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../model/buttlet.dart';
import '../model/particle.dart';
import '../model/player_shooter.dart';

class GameViewModel {
  final int numberOfParticles = 10;
  final Color particleColor = Colors.red;
  final double maxParticleSize = 10.0;

  late PlayerShooter player;

  late List<Particle> particles;

  List<Bullet> bullets = [];

  bool isGameOver = false;

  GameViewModel() {
    player = PlayerShooter(x: 500, y: 500);

    particles = List.generate(
      numberOfParticles,
      (_) => Particle(particleColor, maxParticleSize),
    );
  }

  void dispose() {}

  void updatePlayerPosition(Offset newPosition) {
    player.targetX = newPosition.dx;
    player.targetY = newPosition.dy;
  }

  void updateParticlePosition() {
    for (var it in particles) {
      it.updatePosition();
    }
    player.moveTowardsTarget(
      Size(SchedulerBinding.instance.window.physicalSize.width / window.devicePixelRatio,
          SchedulerBinding.instance.window.physicalSize.height / window.devicePixelRatio),
    );
  }

  void shootBullet() {
    double angle = player.angle;
    Bullet bullet = Bullet(Colors.white, player.x, player.y, angle);
    bullets.add(bullet);
  }

  void updateBulletPosition() {
    for (Bullet bullet in bullets) {
      bullet.move();
    }
    bullets.removeWhere((bullet) => bullet.isOutsideBounds());
  }

  void checkCollisions() {
    for (int i = 0; i < particles.length; i++) {
      if (player.isCollidingWith(particles[i])) {
        // Player collided with a particle, end the game
        isGameOver = true;
        return;
      }

      for (int j = 0; j < bullets.length; j++) {
        if (bullets[j].isCollidingWith(particles[i])) {
          // Bullet collided with a particle, remove the particle
          particles.removeAt(i);
          i--;
          bullets.removeAt(j);
          j--;
        }
      }
    }
  }
}
