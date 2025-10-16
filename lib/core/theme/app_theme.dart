import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EthosTheme {
  EthosTheme._();

  static ThemeData lightTheme(Locale locale) {
    final TextTheme textTheme = GoogleFonts.interTextTheme();
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF1A5D5F),
        secondary: Color(0xFFFF8C42),
        background: Color(0xFFF5F5F5),
        surface: Color(0xFFFFFFFF),
        onPrimary: Color(0xFFFFFFFF),
        onSecondary: Color(0xFFFFFFFF),
        onBackground: Color(0xFF1C1C1C),
        onSurface: Color(0xFF1C1C1C),
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      textTheme: _typography(textTheme, locale),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.5,
        foregroundColor: Color(0xFF1C1C1C),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFFFFF),
        selectedItemColor: Color(0xFF1A5D5F),
        unselectedItemColor: Color(0xFFA0A0A0),
        showUnselectedLabels: true,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF1A5D5F),
        secondarySelectedColor: const Color(0xFFFF8C42),
        labelStyle: _typography(textTheme, locale).bodyMedium!,
        secondaryLabelStyle: _typography(textTheme, locale).bodyMedium!.copyWith(
              color: Colors.white,
            ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: const StadiumBorder(),
      ),
      useMaterial3: false,
    );
  }

  static ThemeData darkTheme(Locale locale) {
    final TextTheme textTheme = GoogleFonts.interTextTheme();
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF1A5D5F),
        secondary: Color(0xFFFF8C42),
        background: Color(0xFF121212),
        surface: Color(0xFF1E1E1E),
        onPrimary: Color(0xFFFFFFFF),
        onSecondary: Color(0xFFFFFFFF),
        onBackground: Color(0xFFFAFAFA),
        onSurface: Color(0xFFFAFAFA),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      textTheme: _typography(textTheme, locale).apply(bodyColor: const Color(0xFFFAFAFA)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0.5,
        foregroundColor: Color(0xFFFAFAFA),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: Color(0xFF1A5D5F),
        unselectedItemColor: Color(0xFFBFBFBF),
        showUnselectedLabels: true,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedColor: const Color(0xFF1A5D5F),
        secondarySelectedColor: const Color(0xFFFF8C42),
        labelStyle: _typography(textTheme, locale).bodyMedium!,
        secondaryLabelStyle: _typography(textTheme, locale).bodyMedium!.copyWith(
              color: Colors.white,
            ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: const StadiumBorder(),
      ),
      useMaterial3: false,
    );
  }

  static TextTheme _typography(TextTheme base, Locale locale) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontSize: 28, fontWeight: FontWeight.w700),
      headlineMedium: base.headlineMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: base.titleMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: base.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: base.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
    );
  }
}
