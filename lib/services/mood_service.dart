import 'package:aura/models/mood_model.dart';
import 'package:fpdart/fpdart.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../providers/common/supabase_provider.dart';

final moodServiceProvider = AutoDisposeProvider<MoodService>(
  (ref) => MoodService(
    client: ref.watch(supabaseProvider),
  ),
);

class MoodService {
  final SupabaseClient _client;

  MoodService({
    required SupabaseClient client,
  }) : _client = client;

  FutureEither<MoodModel> detectMoodFromText({
    required String text,
  }) async {
    try {
      final res = await _client.functions.invoke(
        'detect-mood-text',
        body: {'text': text},
      );

      final moods = MoodModel.fromJson(res.data);

      return Right(moods);
    } catch (e) {
      logError(e.toString());
      return const Left(Failure('Failed to detect mood'));
    }
  }

  FutureEither<MoodModel> detectMoodFromImage({
    required String image,
  }) async {
    try {
      final res = await _client.functions.invoke(
        'detect-mood-image',
        body: {'image': image},
      );

      final moods = MoodModel.fromJson(res.data);

      return Right(moods);
    } catch (e) {
      logError(e.toString());
      return const Left(Failure('Failed to detect mood'));
    }
  }

  FutureVoid addMood({
    required MoodModel mood,
    required String note,
  }) async {
    try {
      await _client.from('moods').insert({
        'user_id': _client.auth.currentUser!.id,
        'mood': mood.mood,
        'score': mood.score,
        'note': note,
        'created_at': DateTime.now().toUtc().toLocal().toString(),
        'mood_data': [
          ...mood.emotions!.map((e) => {
                'label': e.label,
                'score': e.score,
              })
        ],
      });

      return const Right(null);
    } catch (e) {
      logError(e.toString());
      return const Left(Failure('Failed to add mood'));
    }
  }

  Future<MoodModel> getMoodByDate({
    required String date,
  }) async {
    try {
      final newMood = await _client
          .from('moods')
          .select('mood, created_at')
          .gte('created_at', date)
          .order('created_at')
          .limit(1)
          .withConverter(
            (value) => MoodModel.fromJson(value.isEmpty ? {} : value.first),
          );

      return newMood;
    } catch (e) {
      logError(e.toString());
      throw const Failure('Failed to get mood');
    }
  }

  Future<double> getHappyPercentage() async {
    try {
      final totalMoods = await _client
          .from('moods')
          .select('mood')
          .eq('user_id', _client.auth.currentUser!.id)
          .neq('mood', 'happy')
          .count();
      final happyMoods = await _client
          .from('moods')
          .select('mood')
          .eq('user_id', _client.auth.currentUser!.id)
          .eq('mood', 'happy')
          .count();

      final totalCount = totalMoods.count;
      final happyCount = happyMoods.count;

      if (totalCount == 0) {
        return 0;
      }

      return (happyCount / totalCount) * 100;
    } catch (e) {
      logError(e.toString());
      throw const Failure('Failed to get happy percentage');
    }
  }
}
