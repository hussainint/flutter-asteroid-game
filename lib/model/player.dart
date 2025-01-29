// import 'dart:math';

// import 'package:flutter/material.dart';

// class Player {
//   late Color color;
//   double radius = 20.0;
//   double x = 0.0;
//   double y = 0.0;
//   double targetX = 0.0;
//   double targetY = 0.0;
//   double speed = 2.0;

//   Player(Color color) {
//     this.color = color;
//   }

//   void moveTowardsTarget(Size canvasSize) {
//     double angle = atan2(targetY - y, targetX - x);
//     double distance = sqrt(pow(targetX - x, 2) + pow(targetY - y, 2));

//     bool isCursorInsideBounds = targetX >= 0 &&
//         targetX <= canvasSize.width &&
//         targetY >= 0 &&
//         targetY <= canvasSize.height;

//     if (isCursorInsideBounds) {
//       if (distance > speed) {
//         x += cos(angle) * speed;
//         y += sin(angle) * speed;
//       }
//     }
//   }

//   void draw(Canvas canvas, Size canvasSize) {
//     Paint paint = Paint()
//       ..color = color
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill;

//     // final path = Path();
//     // path.moveTo(x, y + 50);
//     // path.lineTo(x - 50, y - 50);
//     // path.lineTo(x, y);
//     // path.lineTo(x + 50, y - 50);

//     // path.close();

//     // canvas.drawPath(path, paint);

//     canvas.drawCircle(Offset(x, y), radius, paint);
//   }
// }
