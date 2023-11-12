
import 'package:get/get.dart';
import '../controllers/wheel_controller.dart';


class WheelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WheelController>(() => WheelController());
  }
}