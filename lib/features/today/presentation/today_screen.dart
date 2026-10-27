import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/l10n/app_strings.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/models/nutrition_summary.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/section_heading.dart';
import '../../food/application/food_log_controller.dart';
import '../../water/application/water_intake_controller.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});
  static const calorieGoal = 2200;
  static const waterGoalMl = 2000;
  static const proteinGoal = 120.0;
  static const carbsGoal = 240.0;
  static const fatGoal = 70.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final entries = ref.watch(foodLogProvider);
    final summary = NutritionSummary.fromEntries(entries);
    final waterMl = ref.watch(waterIntakeProvider);
    final remaining = (calorieGoal - summary.calories).clamp(0, calorieGoal);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.mint,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.spa_rounded,
                  color: AppColors.forest,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'nimbus',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),
                  Text(
                    MaterialLocalizations.of(
                      context,
                    ).formatMediumDate(DateTime.now()),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            s.get('headline'),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              height: 1.08,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            s.get('subtitle'),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 28),
          SectionHeading(title: s.get('nutrition')),
          const SizedBox(height: 12),
          AppCard(
            color: colors.primaryContainer,
            child: Row(
              children: [
                SizedBox(
                  width: 108,
                  height: 108,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 102,
                        height: 102,
                        child: CircularProgressIndicator(
                          value: (summary.calories / calorieGoal)
                              .clamp(0.0, 1.0)
                              .toDouble(),
                          strokeWidth: 9,
                          backgroundColor: colors.onPrimaryContainer.withValues(
                            alpha: 0.12,
                          ),
                          color: colors.primary,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${summary.calories}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colors.onPrimaryContainer,
                            ),
                          ),
                          Text(
                            s.get('eaten'),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colors.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.get('calories'),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$remaining',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        s.get('left'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$calorieGoal ${s.get('daily_goal')}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SectionHeading(title: s.get('macros')),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MacroCard(
                  label: s.get('protein'),
                  amount: summary.proteinGrams,
                  goal: proteinGoal,
                  color: AppColors.mint,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MacroCard(
                  label: s.get('carbs'),
                  amount: summary.carbsGrams,
                  goal: carbsGoal,
                  color: AppColors.warm,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MacroCard(
                  label: s.get('fat'),
                  amount: summary.fatGrams,
                  goal: fatGoal,
                  color: AppColors.lavender,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SectionHeading(
            title: s.get('food_log'),
            actionLabel: s.get('view_food'),
            onAction: () => context.go('/food'),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Row(
              children: [
                Icon(
                  Icons.restaurant_outlined,
                  color: colors.primary,
                  size: 28,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entries.isEmpty
                            ? s.get('empty_food')
                            : entries.last.name,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        entries.isEmpty
                            ? s.get('empty_food_hint')
                            : '${entries.last.calories} kcal',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => context.go('/food'),
                  tooltip: s.get('add_food'),
                  icon: const Icon(Icons.add_circle_outline_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SectionHeading(title: s.get('water')),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.water_drop_rounded,
                      color: Color(0xFF367C96),
                      size: 30,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.get('water'),
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            s.get('water_hint'),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${(waterMl / 1000).toStringAsFixed(waterMl % 1000 == 0 ? 0 : 2)} L',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (waterMl / waterGoalMl).clamp(0.0, 1.0).toDouble(),
                    minHeight: 8,
                    backgroundColor: colors.surfaceContainerHighest,
                    color: const Color(0xFF367C96),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$waterMl ml / $waterGoalMl ml',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    FilledButton.tonalIcon(
                      onPressed: () =>
                          ref.read(waterIntakeProvider.notifier).addGlass(),
                      icon: const Icon(Icons.add_rounded),
                      label: Text(s.get('add_glass')),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            s.get('goal_note'),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _MacroCard extends StatelessWidget {
  const _MacroCard({
    required this.label,
    required this.amount,
    required this.goal,
    required this.color,
  });
  final String label;
  final double amount;
  final double goal;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(13),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            amount.toStringAsFixed(0),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColors.ink,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'g / ${goal.toStringAsFixed(0)} g',
            style: theme.textTheme.labelSmall?.copyWith(color: AppColors.ink),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (amount / goal).clamp(0.0, 1.0).toDouble(),
              minHeight: 5,
              backgroundColor: Colors.white.withValues(alpha: 0.65),
              color: AppColors.forest,
            ),
          ),
        ],
      ),
    );
  }
}
