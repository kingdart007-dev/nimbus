import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/app_strings.dart';
import '../../../app/settings/app_preferences.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/section_heading.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final mode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final theme = Theme.of(context);

    return SafeArea(child: ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      children: [
        Text(s.get('settings'), style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.8)),
        const SizedBox(height: 24),
        SectionHeading(title: s.get('appearance')),
        const SizedBox(height: 8),
        Text(s.get('appearance_hint'), style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 12),
        AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(s.get('theme'), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: ThemeMode.system, label: Text(s.get('system')), icon: const Icon(Icons.brightness_auto_rounded)),
              ButtonSegment(value: ThemeMode.light, label: Text(s.get('light')), icon: const Icon(Icons.light_mode_rounded)),
              ButtonSegment(value: ThemeMode.dark, label: Text(s.get('dark')), icon: const Icon(Icons.dark_mode_rounded)),
            ],
            selected: {mode},
            onSelectionChanged: (selected) => unawaited(ref.read(themeModeProvider.notifier).setMode(selected.first)),
          )),
        ])),
        const SizedBox(height: 24),
        SectionHeading(title: s.get('language')),
        const SizedBox(height: 8),
        Text(s.get('language_hint'), style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 12),
        AppCard(child: Column(children: [
          RadioListTile<String>(
            contentPadding: EdgeInsets.zero, value: 'system', groupValue: locale?.languageCode ?? 'system',
            title: Text(s.get('system')),
            onChanged: (_) => unawaited(ref.read(localeProvider.notifier).setLocale(null)),
          ),
          RadioListTile<String>(
            contentPadding: EdgeInsets.zero, value: 'en', groupValue: locale?.languageCode ?? 'system',
            title: Text(s.get('english')),
            onChanged: (_) => unawaited(ref.read(localeProvider.notifier).setLocale(const Locale('en'))),
          ),
          RadioListTile<String>(
            contentPadding: EdgeInsets.zero, value: 'ar', groupValue: locale?.languageCode ?? 'system',
            title: Text(s.get('arabic')),
            onChanged: (_) => unawaited(ref.read(localeProvider.notifier).setLocale(const Locale('ar'))),
          ),
        ])),
        const SizedBox(height: 24),
        AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.info_outline_rounded, color: theme.colorScheme.primary),
            const SizedBox(width: 10),
            Text('Nimbus · 0.1.0', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 12),
          Text(s.get('storage_note'), style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ])),
      ],
    ));
  }
}
