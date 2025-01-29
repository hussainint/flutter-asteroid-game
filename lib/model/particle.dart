import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'collidable.dart';

class Particle extends Collidable {
  late Color color;
  late List<Offset> vertices;
  double speed = 0.0;
  double direction = 0.0;

  Particle(Color color, double maxParticleSize) : super(0.0, 0.0, 0.0) {
    this.color = color;
    this.speed = 1;
    this.direction = Random().nextDouble() * 360;
    final sides = Random().nextInt(6) + 5; // Random number of sides (5 to 10)

    // Generate vertices for the polygonal asteroid
    vertices = List.generate(sides, (index) {
      final angle = (index / sides) * (2 * pi);
      final radius = Random().nextDouble() * (maxParticleSize / 2) + 30.0;
      final x = radius * cos(angle);
      final y = radius * sin(angle);
      return Offset(x, y);
    });

    //Calculate the radius of the bounding circle
    radius = vertices.fold(0.0, (maxRadius, vertex) {
      final distance = vertex.distance;
      return distance > maxRadius ? distance : maxRadius;
    });
  }

  void draw(Canvas canvas, Size canvasSize) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);
    randomlyChangeDirectionIfEdgeReached(canvasSize);

    final path = Path();
    final startPoint = vertices[0] + Offset(x, y);
    path.moveTo(startPoint.dx, startPoint.dy);

    for (int i = 1; i < vertices.length; i++) {
      final vertex = vertices[i] + Offset(x, y);
      path.lineTo(vertex.dx, vertex.dy);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    if (x == 0.0) {
      x = Random().nextDouble() * canvasSize.width;
    }

    if (y == 0.0) {
      y = Random().nextDouble() * canvasSize.height;
    }
  }

  void updatePosition() {
    if (x == 0.0) return;

    var a = 180 - (direction + 90);
    direction > 0 && direction < 180
        ? x = x + speed * sin(direction) / sin(speed)
        : x = x - speed * sin(direction) / sin(speed);
    direction > 90 && direction < 270
        ? y = y + speed * sin(a) / sin(speed)
        : y = y - speed * sin(a) / sin(speed);
  }

  void randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if (x == 0.0 || y == 0.0) return;
    if (x > canvasSize.width || x < 0 || y > canvasSize.height || y < 0) {
      direction = Random().nextDouble() * 360;
    }
  }
}
