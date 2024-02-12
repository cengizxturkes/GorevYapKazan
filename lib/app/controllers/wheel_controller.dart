import 'dart:async';

import 'package:get/get.dart';

class WheelController extends GetxController {
  final StreamController<int> controller = StreamController<int>.broadcast();

  bool isClicked = true;

  reset() {
    update();
  }

  int selectedValue = 0;

  void valueUpdate(int value) {
    selectedValue = value;
    update();
  }

  int selectedTabbar = 0;

  void changeTabIndex(int index) {
    selectedTabbar = index;
    update();
  }
}
