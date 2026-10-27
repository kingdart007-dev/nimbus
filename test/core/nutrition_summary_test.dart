import 'package:flutter_test/flutter_test.dart';
import 'package:nimbus/core/models/food_entry.dart';
import 'package:nimbus/core/models/nutrition_summary.dart';

void main() {
  group('NutritionSummary.fromEntries', () {
    test('returns zeros for an empty log', () {
      const summary = NutritionSummary.zero();
      expect(summary.calories, 0);
      expect(summary.proteinGrams, 0);
      expect(summary.carbsGrams, 0);
      expect(summary.fatGrams, 0);
    });

    test('sums calories and macronutrients', () {
      final entries = [
        FoodEntry(
          id: '1',
          name: 'Oats',
          calories: 320,
          proteinGrams: 12,
          carbsGrams: 48,
          fatGrams: 8,
          loggedAt: DateTime(2026, 1, 1),
        ),
        FoodEntry(
          id: '2',
          name: 'Yogurt',
          calories: 140,
          proteinGrams: 10.5,
          carbsGrams: 14,
          fatGrams: 4,
          loggedAt: DateTime(2026, 1, 1),
        ),
      ];
      final summary = NutritionSummary.fromEntries(entries);
      expect(summary.calories, 460);
      expect(summary.proteinGrams, 22.5);
      expect(summary.carbsGrams, 62);
      expect(summary.fatGrams, 12);
    });
  });
}
