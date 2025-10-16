import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';
import 'preference_selection_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({required this.appState, super.key});

  static const String routeName = '/role-selection';

  final AppState appState;

  Future<void> _handleSelection(BuildContext context, String role) async {
    await appState.setUserRole(role);
    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(PreferenceSelectionScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<_RoleOption> options = <_RoleOption>[
      _RoleOption(title: l10n.getString('role_seeker'), value: 'Seeker'),
      _RoleOption(title: l10n.getString('role_volunteer'), value: 'Volunteer'),
      _RoleOption(title: l10n.getString('role_coordinator'), value: 'Coordinator'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.getString('role_selection_title')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: options
              .map(
                (_RoleOption option) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () => _handleSelection(context, option.value),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(option.title, style: Theme.of(context).textTheme.titleMedium),
                          Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.primary),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _RoleOption {
  const _RoleOption({required this.title, required this.value});

  final String title;
  final String value;
}
