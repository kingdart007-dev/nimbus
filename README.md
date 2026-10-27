# Nimbus

A calm, thoughtful nutrition and wellness companion built with Flutter and Dart for **Android and iOS**.

Nimbus is designed around one idea: health tracking should feel supportive, clear, and easy—not like another job.

## Included in this first milestone
- Flutter/Dart app structure with Riverpod and GoRouter
- Material 3 interface with system, light, and dark themes
- English and Arabic localization with right-to-left support
- Daily nutrition dashboard with calorie and macro summaries
- Manual food logging, water intake, and workout-session logging
- Shared design components, unit/widget tests, and GitHub Actions

## Not implemented yet
Food, water, and activity entries are in-memory and reset when the process restarts. This build does not include a food database, scanning, AI nutrition estimates, device-health integration, accounts, or cloud sync. It deliberately does not invent steps or calories burned.

If native runner directories are not present, create the Android and iOS project files once:

```sh
flutter create --platforms=android,ios --org dev.nimbus .
flutter pub get
flutter run
```

Do not enable web or desktop targets.

## Quality checks
```sh
dart format .
flutter analyze
flutter test
```

Read [AGENTS.md](AGENTS.md), [architecture](docs/architecture.md), and [the roadmap](docs/roadmap.md) before making major changes. Health estimates must be clearly labelled, sourced where possible, and never presented as medical advice or as a single “perfect weight”.
