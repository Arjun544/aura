import 'package:aura/models/mood_model.dart';
import 'package:aura/utils/moods.dart';
import 'package:fpdart/fpdart.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../providers/common/supabase_provider.dart';

final statsServiceProvider = AutoDisposeProvider<StatsService>(
  (ref) => StatsService(
    client: ref.watch(supabaseProvider),
  ),
);

class StatsService {
  final SupabaseClient _client;

  StatsService({
    required SupabaseClient client,
  }) : _client = client;

  Future<List<MoodModel>> getPercentageByMood() async {
    try {
      final res = await _client
          .from('moods')
          .select('mood')
          .eq('user_id', _client.auth.currentUser!.id);

      if (res.isEmpty) {
        return const [];
      }

      // List of all mood categories
      final allMoods =
          localMoods.map((mood) => mood.mood.toLowerCase()).toList();

      // Map to count occurrences of each mood
      final moodCounts = {for (var mood in allMoods) mood: 0};

      // Count occurrences of each mood from the fetched data
      final moods = res.map((e) => MoodModel.fromJson(e)).toList();
      for (var mood in moods) {
        if (moodCounts.containsKey(mood.mood)) {
          moodCounts[mood.mood!.toLowerCase()] =
              moodCounts[mood.mood!.toLowerCase()]! + 1;
        }
      }

      // Total number of moods
      final total = moods.length;

      // Calculate percentages for each mood
      final List<MoodModel> moodList = allMoods.map((mood) {
        final count = moodCounts[mood] ?? 0;
        final percentage = total > 0 ? (count / total) * 100 : 0;
        return MoodModel(
          mood: mood,
          score: percentage.toDouble(),
        );
      }).toList();

      moodList.sort((a, b) => b.score!.compareTo(a.score!));

      return moodList;
    } catch (e) {
      logError(e.toString());
      throw const Left(Failure('Failed to get percentage by mood'));
    }
  }
}
