import 'package:flutter/services.dart';

class KeyboardInput {
  void addListener(bool Function(KeyEvent) callback) {
    HardwareKeyboard.instance.addHandler(callback);
  }

  void removeListener(bool Function(KeyEvent) callback) {
    HardwareKeyboard.instance.removeHandler(callback);
  }
}
