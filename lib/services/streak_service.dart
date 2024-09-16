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

  Future<int> getUserStreak() async {
    try {
      final int streak = await _client
          .from('streaks')
          .select('streak_count')
          .eq('user_id', _client.auth.currentUser!.id)
          .single()
          .withConverter(
            (value) => value['streak_count'] as int,
          );

      return streak;
    } catch (e) {
      logError(e.toString());
      throw const Left(Failure('Failed to get streak'));
    }
  }
}
