
import 'package:get/get.dart';
import '../controllers/share_controller.dart';


class ShareBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareController>(() => ShareController());
  }
}