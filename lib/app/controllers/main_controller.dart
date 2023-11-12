import 'package:get/get.dart';

import '../../core/constants/preferences_keys.dart';
import '../../core/init/cache/cache_manager.dart';

class MainController extends GetxController {
  @override
  void onInit() {
    KCacheManager.instance.setValue(PreferencesKeys.pageName, "MainPage");
    super.onInit();
  }
}
