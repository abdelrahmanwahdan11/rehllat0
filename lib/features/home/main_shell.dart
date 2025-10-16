import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';
import '../my_trips/my_trips_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_sheet.dart';
import 'home_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({required this.appState, super.key});

  static const String routeName = '/home';

  final AppState appState;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomeScreen(appState: widget.appState),
      const _PlaceholderScreen(label: 'Browse'),
      MyTripsScreen(appState: widget.appState),
      const _PlaceholderScreen(label: 'Messages'),
      ProfileScreen(appState: widget.appState),
    ];
  }

  void _onItemTapped(int index) {
    widget.appState.setTabIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<_NavItem> items = <_NavItem>[
      _NavItem(Icons.home_outlined, l10n.getString('tab_home')),
      _NavItem(Icons.explore_outlined, l10n.getString('tab_browse')),
      _NavItem(Icons.event_outlined, l10n.getString('tab_my_trips')),
      _NavItem(Icons.chat_bubble_outline, l10n.getString('tab_messages')),
      _NavItem(Icons.person_outline, l10n.getString('tab_profile')),
    ];
    return AnimatedBuilder(
      animation: widget.appState,
      builder: (BuildContext context, _) {
        final int currentIndex = widget.appState.currentTabIndex;
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.getString('app_title')),
            actions: <Widget>[
              IconButton(
                onPressed: () => _openSettings(context),
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          body: Directionality(
            textDirection: widget.appState.locale.languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: IndexedStack(
              index: currentIndex,
              children: _pages,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            items: items
                .map(
                  (_NavItem item) => BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    label: item.label,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  void _openSettings(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return SettingsSheet(appState: widget.appState);
      },
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.label);

  final IconData icon;
  final String label;
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
