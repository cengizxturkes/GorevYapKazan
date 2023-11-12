import 'package:get_storage/get_storage.dart';

import '../../constants/preferences_keys.dart';

class KCacheManager {
  static final KCacheManager _instance = KCacheManager._init();

  GetStorage? _preferences;
  static KCacheManager get instance => _instance;

  KCacheManager._init() {
    GetStorage box = GetStorage();
    _preferences = box;
  }

  static init() async {
    GetStorage box = GetStorage();
    instance._preferences ??= box;
    return;
  }

  Future<void> clearAll() async {
    await _preferences?.erase();
  }

  Future<void> setValue(PreferencesKeys key, dynamic value) async {
    await _preferences?.write(key.toString(), value);
  }

  Future<void> setValueWithString(String key, dynamic value) async {
    await _preferences?.write(key.toString(), value);
  }

  dynamic getValue(PreferencesKeys key) => _preferences?.read(key.toString());
  dynamic getValueWithString(String key) => _preferences?.read(key.toString());

  Future<void> clearKey(PreferencesKeys key) async {
    await _preferences?.remove(key.toString());
  }
}
