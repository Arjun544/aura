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
      // logError(image..toString());
      final res = await _client.functions.invoke(
        'detect-mood-image',
        body: {'image': image},
      );

      final moods = MoodModel.fromJson(res.data);
      logSuccess(moods.mood ?? 'No mood detected');

      return Right(moods);
    } catch (e) {
      logError(e.toString());
      return const Left(Failure('Failed to detect mood'));
    }
  }
}
