
import 'package:get/get.dart';
import '../controllers/pullmoney_controller.dart';


class PullMoneyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PullMoneyController>(() => PullMoneyController());
  }
}