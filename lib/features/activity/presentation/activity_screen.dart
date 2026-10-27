import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/app_strings.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/section_heading.dart';
import '../application/activity_log_controller.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final activities = ref.watch(activityLogProvider);
    final minutes = activities.fold<int>(
      0,
      (sum, entry) => sum + entry.minutes,
    );
    final theme = Theme.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
        children: [
          Text(
            s.get('activity_title'),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            s.get('activity_subtitle'),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          AppCard(
            color: AppColors.mint,
            child: Row(
              children: [
                const Icon(
                  Icons.bolt_rounded,
                  color: AppColors.forest,
                  size: 32,
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$minutes ${s.get('minutes')}',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      s.get('recent_activity'),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SectionHeading(title: s.get('log_activity')),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ActivityChoice(
                  title: s.get('walk'),
                  icon: Icons.directions_walk_rounded,
                  tint: AppColors.blueMist,
                  onTap: () => _log(context, ref, s, 'walk'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActivityChoice(
                  title: s.get('run'),
                  icon: Icons.directions_run_rounded,
                  tint: AppColors.warm,
                  onTap: () => _log(context, ref, s, 'run'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActivityChoice(
                  title: s.get('strength'),
                  icon: Icons.fitness_center_rounded,
                  tint: AppColors.lavender,
                  onTap: () => _log(context, ref, s, 'strength'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SectionHeading(title: s.get('recent_activity')),
          const SizedBox(height: 12),
          if (activities.isEmpty)
            AppCard(
              child: Column(
                children: [
                  const Icon(
                    Icons.directions_run_rounded,
                    size: 38,
                    color: AppColors.forest,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    s.get('no_activity'),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    s.get('no_activity_hint'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
          else
            ...activities.reversed.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.forest,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          s.get(entry.type),
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      Text('${entry.minutes} ${s.get('minutes')}'),
                      IconButton(
                        tooltip: s.get('cancel'),
                        onPressed: () => ref
                            .read(activityLogProvider.notifier)
                            .removeActivity(entry.id),
                        icon: const Icon(Icons.close_rounded, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          Text(
            s.get('activity_note'),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityChoice extends StatelessWidget {
  const _ActivityChoice({
    required this.title,
    required this.icon,
    required this.tint,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final Color tint;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
    color: tint,
    onTap: onTap,
    child: Column(
      children: [
        Icon(icon, color: AppColors.ink, size: 28),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.ink,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Future<void> _log(
  BuildContext context,
  WidgetRef ref,
  AppStrings s,
  String type,
) async {
  final controller = TextEditingController(text: '30');
  final formKey = GlobalKey<FormState>();
  final minutes = await showDialog<int>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text('${s.get('log_activity')}: ${s.get(type)}'),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: s.get('duration')),
          validator: (value) {
            final number = int.tryParse(value?.trim() ?? '');
            return number == null || number < 1 || number > 1440
                ? s.get('invalid_number')
                : null;
          },
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
            Navigator.of(dialogContext).pop(int.parse(controller.text.trim()));
          },
          child: Text(s.get('save_session')),
        ),
      ],
    ),
  );
  controller.dispose();
  if (minutes != null) {
    ref
        .read(activityLogProvider.notifier)
        .addActivity(type: type, minutes: minutes);
  }
}
