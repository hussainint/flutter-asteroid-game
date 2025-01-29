import 'dart:math';

import 'package:flutter/material.dart';

import 'collidable.dart';

class PlayerShooter extends Collidable {
  Color color = Colors.white;
  double targetX = 0.0;
  double targetY = 0.0;
  double speed = 2.0;

  PlayerShooter({required double x, required double y}) : super(x, y, 20) {
    this.color = color;
  }

  double get angle {
    return atan2(targetY - y, targetX - x);
  }

  void moveTowardsTarget(Size canvasSize) {
    double angle = atan2(targetY - y, targetX - x);

    double distance = sqrt(pow(targetX - x, 2) + pow(targetY - y, 2));

    // Check if the cursor is within the screen bounds
    bool isCursorInsideBounds =
        targetX >= 0 && targetX <= canvasSize.width && targetY >= 0 && targetY <= canvasSize.height;

    if (isCursorInsideBounds && distance > speed) {
      x += cos(angle) * speed;
      y += sin(angle) * speed;
    }
  }

  void draw(Canvas canvas, Size canvasSize) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    double angle = atan2(targetY - y, targetX - x);

    // Calculate the coordinates of the triangle's vertices
    double x1 = x + cos(angle) * radius;
    double y1 = y + sin(angle) * radius;

    double x2 = x + cos(angle + (120 * (pi / 180))) * radius;
    double y2 = y + sin(angle + (120 * (pi / 180))) * radius;

    double x3 = x + cos(angle + (240 * (pi / 180))) * radius;
    double y3 = y + sin(angle + (240 * (pi / 180))) * radius;

    // Create a path for the modified triangle
    Path path = Path()
      ..moveTo(x1, y1)
      ..lineTo(x2, y2)
      ..lineTo(x3, y3)
      ..close();

    // Draw the cursor
    canvas.drawPath(path, paint);
  }

  /// to draw a circle
  //   void draw(Canvas canvas, Size canvasSize) {
  //   Paint paint = Paint()
  //     ..color = color
  //     ..strokeCap = StrokeCap.round
  //     ..style = PaintingStyle.fill;

  //   canvas.drawCircle(Offset(x, y), radius, paint);
  // }
}
