import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/models/streak_model.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:aura/services/streak_service.dart';

final streakCountProvider = FutureProvider<int>((ref) async {
  ref.watch(userProvider.select((e) => e?.id));
  return ref.read(streakServiceProvider).getStreakCount();
});

final streakProvider = FutureProvider<StreakModel>((ref) async {
  ref.watch(userProvider.select((e) => e?.id));
  return ref.read(streakServiceProvider).getStreak();
});
