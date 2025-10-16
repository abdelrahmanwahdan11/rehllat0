import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/data/mock_data.dart';
import 'core/localization/app_localizations.dart';
import 'core/services/app_state.dart';
import 'core/services/preferences_service.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/splash_screen.dart';
import 'features/onboarding/role_selection_screen.dart';
import 'features/onboarding/preference_selection_screen.dart';
import 'features/auth/auth_screen.dart';
import 'features/home/main_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final PreferencesService preferences = await PreferencesService.create();
  final AppState appState = AppState(
    dataRepository: MockDataRepository(),
    preferences: preferences,
  );
  await appState.initialize();
  runApp(EthosApp(appState: appState));
}

class EthosApp extends StatelessWidget {
  const EthosApp({required this.appState, super.key});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (BuildContext context, _) {
        final Locale locale = appState.locale;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ethos',
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: EthosTheme.lightTheme(locale),
          darkTheme: EthosTheme.darkTheme(locale),
          themeMode: appState.themeMode,
          initialRoute: SplashScreen.routeName,
          routes: <String, WidgetBuilder>{
            SplashScreen.routeName: (_) => SplashScreen(appState: appState),
            AuthScreen.routeName: (_) => AuthScreen(appState: appState),
            RoleSelectionScreen.routeName: (_) => RoleSelectionScreen(appState: appState),
            PreferenceSelectionScreen.routeName: (_) => PreferenceSelectionScreen(appState: appState),
            MainShell.routeName: (_) => MainShell(appState: appState),
          },
        );
      },
    );
  }
}
