
import 'package:get/get.dart';
import '../controllers/chest_controller.dart';


class ChestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChestController>(() => ChestController());
  }
}