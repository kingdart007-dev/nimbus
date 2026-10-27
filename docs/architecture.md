# Architecture

Nimbus is a Flutter/Dart mobile app using Riverpod for state, GoRouter for navigation, and a feature-first structure.

```text
lib/
  app/       app root, routing, theme, preferences, manual localization
  core/      plain Dart domain models and shared widgets
  features/  today, food, activity, water
```

## State and storage
- Riverpod notifiers own feature state.
- Theme and locale preference use SharedPreferences.
- Food, water, and activity logs are currently in-memory starter state. Local database/migrations are planned and no sync is implemented.
- AI, food search, scanning, sensors, accounts, and cloud sync are not wired up.

## Localization and design
English and Arabic use a manual localization delegate (no generated localization code). Flutter's locale handling provides RTL directionality. Keep shared UI on the centralized Material 3 theme and `AppCard`.

## Nutrition integrity
Calculations summarize values entered by the user; they are not medical guidance. Do not infer health metrics without a defensible method and transparent limitations.
