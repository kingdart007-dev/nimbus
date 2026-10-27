# Contributing

Nimbus values correctness, clarity, accessibility, and sustainable iteration over clever abstractions.

## Setup
Install the stable Flutter SDK and Android/iOS tooling for your machine. If the native runner folders are not present, create them once:

```sh
flutter create --platforms=android,ios --org dev.nimbus .
flutter pub get
```

Do not select web, Windows, Linux, or macOS targets.

## Checks
```sh
dart format .
flutter analyze
flutter test
```

Keep user-facing copy concise and non-judgmental. Add tests for calculations and state changes. Clearly separate measured data, manual inputs, and estimates. New dependencies should have a clear reason.
