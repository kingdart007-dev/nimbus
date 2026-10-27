import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/app_strings.dart';
import 'router/app_router.dart';
import 'settings/app_preferences.dart';
import 'theme/app_theme.dart';

class NimbusApp extends ConsumerWidget {
  const NimbusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Nimbus',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ref.watch(themeModeProvider),
      locale: ref.watch(localeProvider),
      supportedLocales: AppStrings.supportedLocales,
      localizationsDelegates: AppStrings.localizationsDelegates,
      routerConfig: appRouter,
    );
  }
}
