import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityEntry {
  const ActivityEntry({required this.id, required this.type, required this.minutes, required this.loggedAt});
  final String id;
  final String type;
  final int minutes;
  final DateTime loggedAt;
}

final activityLogProvider =
    NotifierProvider<ActivityLogController, List<ActivityEntry>>(ActivityLogController.new);

class ActivityLogController extends Notifier<List<ActivityEntry>> {
  @override
  List<ActivityEntry> build() => const [];

  void addActivity({required String type, required int minutes}) {
    final now = DateTime.now();
    state = [...state, ActivityEntry(id: now.microsecondsSinceEpoch.toString(), type: type, minutes: minutes, loggedAt: now)];
  }

  void removeActivity(String id) {
    state = state.where((entry) => entry.id != id).toList(growable: false);
  }
}
