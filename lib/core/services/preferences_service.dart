import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService(this._preferences);

  final SharedPreferences _preferences;

  static const String localeKey = 'locale';
  static const String themeModeKey = 'theme_mode';
  static const String userRoleKey = 'user_role';
  static const String userPreferencesKey = 'user_preferences';
  static const String savedExperiencesKey = 'saved_experiences';
  static const String joinedTripsKey = 'joined_trips';

  static Future<PreferencesService> create() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return PreferencesService(prefs);
  }

  Future<void> setLocale(String localeCode) async {
    await _preferences.setString(localeKey, localeCode);
  }

  String? getLocale() => _preferences.getString(localeKey);

  Future<void> setThemeMode(String themeMode) async {
    await _preferences.setString(themeModeKey, themeMode);
  }

  String? getThemeMode() => _preferences.getString(themeModeKey);

  Future<void> setStringList(String key, List<String> values) async {
    await _preferences.setStringList(key, values);
  }

  List<String> getStringList(String key) => _preferences.getStringList(key) ?? <String>[];

  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String? getString(String key) => _preferences.getString(key);
}
