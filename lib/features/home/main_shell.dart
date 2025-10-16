import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';
import '../browse/browse_screen.dart';
import '../create_trip/create_trip_screen.dart';
import '../my_trips/my_trips_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_sheet.dart';
import '../../widgets/animated_gradient_background.dart';
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
      BrowseScreen(appState: widget.appState),
      CreateTripScreen(appState: widget.appState),
      MyTripsScreen(appState: widget.appState),
      ProfileScreen(appState: widget.appState),
    ];
  }

  void _onItemTapped(int index) {
    widget.appState
      ..setTabIndex(index)
      ..setActiveGradientType(_gradientTypeForIndex(index));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<_NavItem> items = <_NavItem>[
      _NavItem(Icons.home_outlined, l10n.getString('tab_home')),
      _NavItem(Icons.explore_outlined, l10n.getString('tab_browse')),
      _NavItem(Icons.add_circle_outline, l10n.getString('tab_create')),
      _NavItem(Icons.event_outlined, l10n.getString('tab_my_trips')),
      _NavItem(Icons.person_outline, l10n.getString('tab_profile')),
    ];
    return AnimatedBuilder(
      animation: widget.appState,
      builder: (BuildContext context, _) {
        final int currentIndex = widget.appState.currentTabIndex;
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(l10n.getString('app_title')),
            actions: <Widget>[
              IconButton(
                onPressed: () => _openSettings(context),
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          body: AnimatedGradientBackground(
            type: widget.appState.activeGradientType,
            child: Directionality(
              textDirection: widget.appState.locale.languageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: IndexedStack(
                index: currentIndex,
                children: _pages,
              ),
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

String _gradientTypeForIndex(int index) {
  switch (index) {
    case 1:
      return 'Cultural';
    case 2:
      return 'Private';
    case 3:
      return 'Volunteer';
    case 4:
      return 'Scientific';
    default:
      return 'Tourism';
  }
}

class _NavItem {
  const _NavItem(this.icon, this.label);

  final IconData icon;
  final String label;
}
