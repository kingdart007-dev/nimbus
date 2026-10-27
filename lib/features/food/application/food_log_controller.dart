import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/food_entry.dart';

final foodLogProvider =
    NotifierProvider<FoodLogController, List<FoodEntry>>(FoodLogController.new);

class FoodLogController extends Notifier<List<FoodEntry>> {
  @override
  List<FoodEntry> build() => const [];

  void addEntry(FoodEntryDraft draft) {
    final now = DateTime.now();
    state = [
      ...state,
      FoodEntry(
        id: now.microsecondsSinceEpoch.toString(),
        name: draft.name.trim(),
        calories: draft.calories,
        proteinGrams: draft.proteinGrams,
        carbsGrams: draft.carbsGrams,
        fatGrams: draft.fatGrams,
        loggedAt: now,
      ),
    ];
  }

  void removeEntry(String id) {
    state = state.where((entry) => entry.id != id).toList(growable: false);
  }
}
