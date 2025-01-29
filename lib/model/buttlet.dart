import 'dart:math';
import 'dart:ui';

import 'collidable.dart';

class Bullet extends Collidable {
  Color color;
  double x;
  double y;
  double angle;
  double speed = 5.0;

  Bullet(this.color, this.x, this.y, this.angle) : super(0.0, 0.0, 2.0);

  void move() {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }

  bool isOutsideBounds() {
    // Implement logic to check if the bullet is outside the screen bounds
    return x < 0 ||
        x > window.physicalSize.width / window.devicePixelRatio ||
        y < 0 ||
        y > window.physicalSize.height / window.devicePixelRatio;
  }

  void draw(Canvas canvas, Size canvasSize) {
    Paint bulletPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(x, y), 2.0, bulletPaint);
  }
}
