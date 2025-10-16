import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({required this.appState, super.key});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.getString('settings_title'), style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.getString('language_label')),
            trailing: SegmentedButton<String>(
              segments: <ButtonSegment<String>>[
                ButtonSegment<String>(value: 'ar', label: Text('العربية')),
                ButtonSegment<String>(value: 'en', label: Text('English')),
              ],
              selected: <String>{appState.locale.languageCode},
              onSelectionChanged: (Set<String> value) {
                final String code = value.first;
                appState.setLocale(Locale(code));
              },
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.getString('theme_label')),
            value: appState.themeMode == ThemeMode.dark,
            onChanged: (_) => appState.toggleThemeMode(),
          ),
        ],
      ),
    );
  }
}
