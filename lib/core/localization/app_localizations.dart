import 'dart:async';

import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const Map<String, Map<String, String>> _localizedValues = <String, Map<String, String>>{
    'ar': <String, String>{
      'app_title': 'إيثوس — الرحلات الهادفة',
      'cta_join_now': 'انضم الآن',
      'cta_done': 'تم',
      'tab_home': 'الرئيسية',
      'tab_browse': 'استكشاف',
      'tab_create': 'إنشاء',
      'tab_my_trips': 'رحلاتي',
      'tab_messages': 'الرسائل',
      'tab_profile': 'الملف',
      'search_hint': 'ابحث عن رحلة...',
      'filters_title': 'التصفية',
      'sort_title': 'الفرز',
      'role_seeker': 'باحث',
      'role_volunteer': 'متطوع',
      'role_coordinator': 'منسق',
      'section_recommended': 'مقترحة لك',
      'section_nearby': 'قريبة منك',
      'section_volunteer': 'فرص تطوعية جديدة',
      'label_free': 'مجانية',
      'label_price': 'السعر',
      'label_location': 'الموقع',
      'label_time': 'الوقت',
      'msg_error_generic': 'حدث خطأ غير متوقع.',
      'role_selection_title': 'اختر دورك',
      'preference_title': 'حدّد اهتماماتك',
      'home_greeting': 'مرحباً بك في إيثوس',
      'my_trips_title': 'رحلاتي',
      'profile_title': 'ملفي',
      'settings_title': 'الإعدادات',
      'language_label': 'اللغة',
      'theme_label': 'الوضع الداكن',
    },
    'en': <String, String>{
      'app_title': 'Ethos — Purposeful Trips',
      'cta_join_now': 'Join Now',
      'cta_done': 'Done',
      'tab_home': 'Home',
      'tab_browse': 'Browse',
      'tab_create': 'Create',
      'tab_my_trips': 'My Trips',
      'tab_messages': 'Messages',
      'tab_profile': 'Profile',
      'search_hint': 'Search trips...',
      'filters_title': 'Filters',
      'sort_title': 'Sort',
      'role_seeker': 'Seeker',
      'role_volunteer': 'Volunteer',
      'role_coordinator': 'Coordinator',
      'section_recommended': 'Recommended for You',
      'section_nearby': 'Nearby',
      'section_volunteer': 'New Volunteer Opportunities',
      'label_free': 'Free',
      'label_price': 'Price',
      'label_location': 'Location',
      'label_time': 'Time',
      'msg_error_generic': 'An unexpected error occurred.',
      'role_selection_title': 'Choose your role',
      'preference_title': 'Select your interests',
      'home_greeting': 'Welcome to Ethos',
      'my_trips_title': 'My Trips',
      'profile_title': 'Profile',
      'settings_title': 'Settings',
      'language_label': 'Language',
      'theme_label': 'Dark Mode',
    },
  };

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String getString(String key) {
    final Map<String, String>? strings = _localizedValues[locale.languageCode];
    return strings?[key] ?? _localizedValues['en']![key] ?? key;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = <Locale>[Locale('ar'), Locale('en')];
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.map((Locale e) => e.languageCode).contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
