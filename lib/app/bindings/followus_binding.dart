
import 'package:get/get.dart';
import '../controllers/followus_controller.dart';


class FollowUsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowUsController>(() => FollowUsController());
  }
}