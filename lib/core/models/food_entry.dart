class FoodEntry {
  const FoodEntry({
    required this.id,
    required this.name,
    required this.calories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    required this.loggedAt,
  });

  final String id;
  final String name;
  final int calories;
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;
  final DateTime loggedAt;
}

class FoodEntryDraft {
  const FoodEntryDraft({
    required this.name,
    required this.calories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
  });

  final String name;
  final int calories;
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;
}
