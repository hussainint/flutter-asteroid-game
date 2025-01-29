import 'dart:math';

class Collidable {
  double x = 0.0;
  double y = 0.0;
  double radius = 0.0;

  Collidable(this.x, this.y, this.radius);

  bool isCollidingWith(Collidable other) {
    double dx = x - other.x;
    double dy = y - other.y;
    double distance = sqrt(dx * dx + dy * dy);

    return distance < radius + other.radius;
  }
}
