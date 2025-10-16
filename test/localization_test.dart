import 'package:ethos/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppLocalizations returns translated value', () {
    final AppLocalizations localizations = AppLocalizations(const Locale('en'));
    expect(localizations.getString('app_title'), 'Ethos — Purposeful Trips');
  });

  test('AppLocalizations falls back to key when missing', () {
    final AppLocalizations localizations = AppLocalizations(const Locale('en'));
    expect(localizations.getString('unknown_key'), 'unknown_key');
  });
}
