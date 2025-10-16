import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import 'preferences_service.dart';

class AppState extends ChangeNotifier {
  AppState({required this.dataRepository, required this.preferences});

  final MockDataRepository dataRepository;
  final PreferencesService preferences;

  Locale _locale = const Locale('ar');
  ThemeMode _themeMode = ThemeMode.light;
  int _currentTabIndex = 0;
  String _activeGradientType = 'Tourism';
  String? _userRole;
  List<String> _userPreferences = <String>[];
  List<String> _savedExperiences = <String>[];
  List<String> _joinedTrips = <String>[];

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  int get currentTabIndex => _currentTabIndex;
  String get activeGradientType => _activeGradientType;
  String? get userRole => _userRole;
  List<String> get savedExperiences => _savedExperiences;
  List<String> get joinedTrips => _joinedTrips;
  List<String> get userPreferences => _userPreferences;

  Future<void> initialize() async {
    final String? storedLocale = preferences.getLocale();
    if (storedLocale != null) {
      _locale = Locale(storedLocale);
    }
    final String? theme = preferences.getThemeMode();
    if (theme != null) {
      _themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
    _userRole = preferences.getString(PreferencesService.userRoleKey);
    _userPreferences = preferences.getStringList(PreferencesService.userPreferencesKey);
    _savedExperiences = preferences.getStringList(PreferencesService.savedExperiencesKey);
    _joinedTrips = preferences.getStringList(PreferencesService.joinedTripsKey);
    notifyListeners();
  }

  void setTabIndex(int index) {
    if (_currentTabIndex == index) {
      return;
    }
    _currentTabIndex = index;
    notifyListeners();
  }

  void setActiveGradientType(String type) {
    if (_activeGradientType == type) {
      return;
    }
    _activeGradientType = type;
    notifyListeners();
  }

  Future<void> toggleLocale() async {
    if (_locale.languageCode == 'ar') {
      _locale = const Locale('en');
    } else {
      _locale = const Locale('ar');
    }
    await preferences.setLocale(_locale.languageCode);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await preferences.setLocale(locale.languageCode);
    notifyListeners();
  }

  Future<void> toggleThemeMode() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await preferences.setThemeMode(_themeMode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }

  Future<void> setUserRole(String role) async {
    _userRole = role;
    await preferences.setString(PreferencesService.userRoleKey, role);
    notifyListeners();
  }

  Future<void> updateUserPreferences(List<String> preferencesList) async {
    _userPreferences = List<String>.from(preferencesList);
    await preferences.setStringList(PreferencesService.userPreferencesKey, _userPreferences);
    notifyListeners();
  }

  Future<void> toggleSavedExperience(String experienceId) async {
    if (_savedExperiences.contains(experienceId)) {
      _savedExperiences = List<String>.from(_savedExperiences)..remove(experienceId);
    } else {
      _savedExperiences = List<String>.from(_savedExperiences)..add(experienceId);
    }
    await preferences.setStringList(PreferencesService.savedExperiencesKey, _savedExperiences);
    notifyListeners();
  }

  Future<void> joinTrip(String experienceId) async {
    if (_joinedTrips.contains(experienceId)) {
      return;
    }
    _joinedTrips = List<String>.from(_joinedTrips)..add(experienceId);
    await preferences.setStringList(PreferencesService.joinedTripsKey, _joinedTrips);
    notifyListeners();
  }
}
