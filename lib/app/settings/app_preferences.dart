import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferencesAsync>(
  (ref) => SharedPreferencesAsync(),
);
final initialThemeModeProvider = Provider<ThemeMode>((ref) => ThemeMode.system);
final initialLocaleProvider = Provider<Locale?>((ref) => null);

final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
);

class ThemeModeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.watch(initialThemeModeProvider);

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    try {
      await ref
          .read(sharedPreferencesProvider)
          .setString('theme_mode', mode.name);
    } catch (_) {
      // This session still honours the setting when persistence fails.
    }
  }
}

final localeProvider = NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);

class LocaleController extends Notifier<Locale?> {
  @override
  Locale? build() => ref.watch(initialLocaleProvider);

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    try {
      await ref
          .read(sharedPreferencesProvider)
          .setString('locale', locale?.languageCode ?? 'system');
    } catch (_) {
      // This session still honours the setting when persistence fails.
    }
  }
}
