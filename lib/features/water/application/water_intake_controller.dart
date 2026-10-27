import 'package:flutter_riverpod/flutter_riverpod.dart';

final waterIntakeProvider = NotifierProvider<WaterIntakeController, int>(
  WaterIntakeController.new,
);

class WaterIntakeController extends Notifier<int> {
  static const glassSizeMl = 250;
  @override
  int build() => 0;
  void addGlass() => state += glassSizeMl;
  void reset() => state = 0;
}
