import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimbus/app/nimbus_app.dart';
import 'package:nimbus/app/settings/app_preferences.dart';

void main() {
  testWidgets('shows the Today dashboard', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialThemeModeProvider.overrideWithValue(ThemeMode.light),
          initialLocaleProvider.overrideWithValue(const Locale('en')),
        ],
        child: const NimbusApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Your day, in balance.'), findsOneWidget);
    expect(find.text('Nutrition today'), findsOneWidget);
  });

  testWidgets('switches to the Food tab', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialThemeModeProvider.overrideWithValue(ThemeMode.light),
          initialLocaleProvider.overrideWithValue(const Locale('en')),
        ],
        child: const NimbusApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Food').last);
    await tester.pumpAndSettle();
    expect(find.text('Your food'), findsOneWidget);
  });
}
