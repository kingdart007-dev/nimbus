import 'food_entry.dart';

class NutritionSummary {
  const NutritionSummary({
    required this.calories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
  });

  const NutritionSummary.zero()
      : calories = 0,
        proteinGrams = 0,
        carbsGrams = 0,
        fatGrams = 0;

  final int calories;
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;

  factory NutritionSummary.fromEntries(Iterable<FoodEntry> entries) {
    var calories = 0;
    var protein = 0.0;
    var carbs = 0.0;
    var fat = 0.0;
    for (final entry in entries) {
      calories += entry.calories;
      protein += entry.proteinGrams;
      carbs += entry.carbsGrams;
      fat += entry.fatGrams;
    }
    return NutritionSummary(
      calories: calories,
      proteinGrams: protein,
      carbsGrams: carbs,
      fatGrams: fat,
    );
  }
}
