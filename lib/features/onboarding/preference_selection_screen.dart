import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';
import '../home/main_shell.dart';

class PreferenceSelectionScreen extends StatefulWidget {
  const PreferenceSelectionScreen({required this.appState, super.key});

  static const String routeName = '/preferences';

  final AppState appState;

  @override
  State<PreferenceSelectionScreen> createState() => _PreferenceSelectionScreenState();
}

class _PreferenceSelectionScreenState extends State<PreferenceSelectionScreen> {
  final Set<String> _selectedInterests = <String>{};
  final Set<String> _selectedSkills = <String>{};

  Future<void> _submit() async {
    final List<String> combined = <String>[..._selectedInterests, ..._selectedSkills];
    await widget.appState.updateUserPreferences(combined);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(MainShell.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<String> interests = <String>['طبيعة', 'ثقافة', 'رياضة', 'تعليم', 'تطوع'];
    final List<String> skills = <String>['التصوير', 'الترجمة', 'الإسعافات الأولية', 'النجارة'];
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.getString('preference_title')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _ChipSection(
              title: 'Interests',
              options: interests,
              selected: _selectedInterests,
              onChanged: (String value) {
                setState(() {
                  if (_selectedInterests.contains(value)) {
                    _selectedInterests.remove(value);
                  } else {
                    _selectedInterests.add(value);
                  }
                });
              },
            ),
            const SizedBox(height: 24),
            _ChipSection(
              title: 'Skills',
              options: skills,
              selected: _selectedSkills,
              onChanged: (String value) {
                setState(() {
                  if (_selectedSkills.contains(value)) {
                    _selectedSkills.remove(value);
                  } else {
                    _selectedSkills.add(value);
                  }
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(l10n.getString('cta_done')),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipSection extends StatelessWidget {
  const _ChipSection({
    required this.title,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final String title;
  final List<String> options;
  final Set<String> selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: options
              .map(
                (String option) => FilterChip(
                  label: Text(option),
                  selected: selected.contains(option),
                  onSelected: (_) => onChanged(option),
                  shape: const StadiumBorder(),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
