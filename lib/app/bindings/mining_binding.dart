
import 'package:get/get.dart';
import '../controllers/mining_controller.dart';


class MiningBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiningController>(() => MiningController());
  }
}