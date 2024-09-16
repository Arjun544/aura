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

  /// Retrieves a list of happy percentages for the current user over the last 7 days.
  Future<List<double>> getHappyPercentages() async {
    try {
      final List<double> percentages = await _client
          .from('percentages')
          .select('happy_percentage')
          .eq('user_id', _client.auth.currentUser!.id)
          .gte(
            'created_at',
            formatDate(DateTime.now().subtract(const Duration(days: 7)),
                [yyyy, '-', mm, '-', dd]),
          )
          .order('created_at')
          .withConverter(
            (value) => value
                .map(
                  (e) => (e['happy_percentage'] as num).toDouble(),
                )
                .toList(),
          );

      return percentages;
    } catch (e) {
      logError(e.toString());
      throw const Failure('Failed to get happy percentage');
    }
  }
}
