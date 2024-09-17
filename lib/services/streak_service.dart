import 'package:aura/models/streak_model.dart';
import 'package:fpdart/fpdart.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../providers/common/supabase_provider.dart';

final streakServiceProvider = AutoDisposeProvider<StreakService>(
  (ref) => StreakService(
    client: ref.watch(supabaseProvider),
  ),
);

class StreakService {
  final SupabaseClient _client;

  StreakService({
    required SupabaseClient client,
  }) : _client = client;

  Future<int> getStreakCount() async {
    try {
      final int streak = await _client
          .from('streaks')
          .select('streak_count')
          .eq('user_id', _client.auth.currentUser!.id)
          .limit(1)
          .withConverter(
            (value) => value.isEmpty ? 0 : value[0]['streak_count'] as int,
          );

      return streak;
    } catch (e) {
      logError(e.toString());
      throw const Left(Failure('Failed to get streak'));
    }
  }

  Future<StreakModel> getStreak() async {
    try {
      final streak = await _client
          .from('streaks')
          .select('*')
          .eq('user_id', _client.auth.currentUser!.id)
          .limit(1)
          .withConverter<StreakModel>(
            (value) => value.isEmpty ? StreakModel(
              streakCount: 0,
              longestStreak: 0,
              
            ) : StreakModel.fromJson(value[0]),
          );

      return streak;
    } catch (e) {
      logError(e.toString());
      throw const Left(Failure('Failed to get streak'));
    }
  }
}
