import 'dart:async';

import 'package:flutter/services.dart';

class PlayerMovementViewModel {
  bool isMovingLeft = false;
  bool isMovingRight = false;
  bool isMovingUp = false;
  bool isMovingDown = false;

  Timer? _movementTimer;

  void startHandling(Function updateMovement) {
    RawKeyboard.instance.addListener((event) {
      if (event is RawKeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          isMovingUp = true;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          isMovingDown = true;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          isMovingLeft = true;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          isMovingRight = true;
        }
        _startMovementTimer(updateMovement);
      } else if (event is RawKeyUpEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          isMovingUp = false;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          isMovingDown = false;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          isMovingLeft = false;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          isMovingRight = false;
        }
        if (!(isMovingUp || isMovingDown || isMovingLeft || isMovingRight)) {
          _stopMovementTimer();
        }
      }
    });
  }

  void stopHandling() {
    RawKeyboard.instance.removeListener((event) {});
    _stopMovementTimer();
  }

  void _startMovementTimer(Function updateMovement) {
    if (_movementTimer == null || !_movementTimer!.isActive) {
      _movementTimer = Timer.periodic(Duration(milliseconds: 16), (_) {
        double moveDistance = 5.0;

        if (isMovingUp) {
          updateMovement(moveDistance, 0);
        }
        if (isMovingDown) {
          updateMovement(-moveDistance, 0);
        }
        if (isMovingLeft) {
          updateMovement(0, -moveDistance);
        }
        if (isMovingRight) {
          updateMovement(0, moveDistance);
        }
      });
    }
  }

  void _stopMovementTimer() {
    if (_movementTimer != null && _movementTimer!.isActive) {
      _movementTimer!.cancel();
    }
  }
}
