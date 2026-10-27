import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/nimbus_app.dart';
import 'app/settings/app_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = SharedPreferencesAsync();
  var initialTheme = ThemeMode.system;
  Locale? initialLocale;

  try {
    final savedTheme = await preferences.getString('theme_mode');
    initialTheme = ThemeMode.values.firstWhere(
      (mode) => mode.name == savedTheme,
      orElse: () => ThemeMode.system,
    );
    final savedLocale = await preferences.getString('locale');
    if (savedLocale == 'en' || savedLocale == 'ar') {
      initialLocale = Locale(savedLocale!);
    }
  } catch (_) {
    // System defaults keep the app usable when preferences are unavailable.
  }

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        initialThemeModeProvider.overrideWithValue(initialTheme),
        initialLocaleProvider.overrideWithValue(initialLocale),
      ],
      child: const NimbusApp(),
    ),
  );
}
