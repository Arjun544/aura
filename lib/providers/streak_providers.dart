import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:aura/services/streak_service.dart';

final streakProvider = FutureProvider<int>((ref) async {
  ref.watch(userProvider.select((e) => e?.id));
  return ref.read(streakServiceProvider).getUserStreak();
});
