# Nimbus engineering instructions

## Product boundaries
- Build a mobile app for Android and iOS with Flutter and Dart. Do not add web or desktop targets.
- Keep the product calm, clear, low-friction, and accessible.
- Never fabricate steps, calories burned, food facts, AI results, biological age, or health readings.
- Distinguish user-entered values, device measurements, and estimates. Label estimates and preserve provenance.
- Avoid shame-based language and the idea of a single “perfect weight”.

## Engineering rules
- Use Riverpod for state and GoRouter for navigation.
- Prefer feature-first folders, immutable plain Dart models, and small cohesive widgets.
- Keep business rules out of presentation widgets.
- Use centralized design tokens, shared components, and localization keys.
- Do not add Freezed, build_runner, generated model code, or a code-generation workflow.
- Keep secrets and API keys out of the mobile app repository.
- Support English and Arabic and check right-to-left layouts.
- Respect system theme by default; persist explicit theme/language choices.

## Before declaring a change done
Run `dart format .`, `flutter analyze`, and `flutter test`. If Flutter is unavailable locally, say so and rely on CI rather than claiming the checks passed.
