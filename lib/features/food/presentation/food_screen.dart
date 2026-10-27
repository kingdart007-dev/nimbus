import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/app_strings.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/models/food_entry.dart';
import '../../../core/models/nutrition_summary.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/section_heading.dart';
import '../application/food_log_controller.dart';

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final entries = ref.watch(foodLogProvider);
    final total = NutritionSummary.fromEntries(entries);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
        children: [
          Text(
            s.get('food_title'),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            s.get('food_subtitle'),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Row(
              children: [
                Expanded(
                  child: _SummaryValue(
                    label: s.get('calories'),
                    value: '${total.calories}',
                    unit: 'kcal',
                  ),
                ),
                Expanded(
                  child: _SummaryValue(
                    label: s.get('protein'),
                    value: total.proteinGrams.toStringAsFixed(0),
                    unit: s.get('grams'),
                  ),
                ),
                Expanded(
                  child: _SummaryValue(
                    label: s.get('carbs'),
                    value: total.carbsGrams.toStringAsFixed(0),
                    unit: s.get('grams'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SectionHeading(title: s.get('food_log')),
          const SizedBox(height: 12),
          if (entries.isEmpty)
            AppCard(
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.mint,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu_rounded,
                      color: AppColors.forest,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    s.get('no_entries'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    s.get('no_entries_hint'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: () => _showAddDialog(context, ref, s),
                    icon: const Icon(Icons.add_rounded),
                    label: Text(s.get('add_food')),
                  ),
                ],
              ),
            )
          else
            ...entries.reversed.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.mint,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.lunch_dining_rounded,
                          color: AppColors.forest,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${entry.proteinGrams.toStringAsFixed(0)} g ${s.get('protein')} · ${entry.carbsGrams.toStringAsFixed(0)} g ${s.get('carbs')} · ${entry.fatGrams.toStringAsFixed(0)} g ${s.get('fat')}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${entry.calories}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Text('kcal', style: TextStyle(fontSize: 11)),
                        ],
                      ),
                      IconButton(
                        tooltip: s.get('cancel'),
                        onPressed: () => ref
                            .read(foodLogProvider.notifier)
                            .removeEntry(entry.id),
                        icon: const Icon(Icons.close_rounded, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (entries.isNotEmpty) ...[
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () => _showAddDialog(context, ref, s),
              icon: const Icon(Icons.add_rounded),
              label: Text(s.get('add_food')),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            s.get('storage_note'),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryValue extends StatelessWidget {
  const _SummaryValue({
    required this.label,
    required this.value,
    required this.unit,
  });
  final String label;
  final String value;
  final String unit;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        value,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
      ),
      Text(unit, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
}

Future<void> _showAddDialog(
  BuildContext context,
  WidgetRef ref,
  AppStrings s,
) async {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final calories = TextEditingController();
  final protein = TextEditingController(text: '0');
  final carbs = TextEditingController(text: '0');
  final fat = TextEditingController(text: '0');

  final draft = await showDialog<FoodEntryDraft>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(s.get('add_food')),
      scrollable: true,
      content: Form(
        key: formKey,
        child: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: name,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: s.get('food_name')),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? s.get('required') : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: calories,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: s.get('calories')),
                validator: (v) => _validateNumber(v, s, required: true),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: protein,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: s.get('protein_short'),
                      ),
                      validator: (v) => _validateNumber(v, s),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: carbs,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: s.get('carbs_short'),
                      ),
                      validator: (v) => _validateNumber(v, s),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: fat,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: s.get('fat_short'),
                      ),
                      validator: (v) => _validateNumber(v, s),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(s.get('cancel')),
        ),
        FilledButton(
          onPressed: () {
            if (!(formKey.currentState?.validate() ?? false)) return;
            Navigator.of(dialogContext).pop(
              FoodEntryDraft(
                name: name.text.trim(),
                calories: double.parse(calories.text).round(),
                proteinGrams: double.tryParse(protein.text) ?? 0,
                carbsGrams: double.tryParse(carbs.text) ?? 0,
                fatGrams: double.tryParse(fat.text) ?? 0,
              ),
            );
          },
          child: Text(s.get('save')),
        ),
      ],
    ),
  );
  name.dispose();
  calories.dispose();
  protein.dispose();
  carbs.dispose();
  fat.dispose();
  if (draft != null) ref.read(foodLogProvider.notifier).addEntry(draft);
}

String? _validateNumber(String? value, AppStrings s, {bool required = false}) {
  final input = value?.trim() ?? '';
  if (input.isEmpty && !required) {
    return null;
  }
  final number = double.tryParse(input);
  if (number == null || number < 0 || !number.isFinite) {
    return s.get('invalid_number');
  }
  return null;
}
