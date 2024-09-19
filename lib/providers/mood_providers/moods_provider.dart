import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:aura/services/ai_service.dart';
import 'package:aura/services/mood_service.dart';

final latestMoodProvider = FutureProvider<MoodModel?>((ref) {
  ref.watch(userProvider.select((e) => e?.id));
  return ref.read(moodServiceProvider).getLatestMood();
});

final dayMoodProvider =
    FutureProvider.family<MoodModel, String>((ref, date) async {
  ref.watch(userProvider.select((e) => e?.id));
  return ref.read(moodServiceProvider).getMoodByDate(date: date);
});

final happyPercentageProvider = FutureProvider<List<MoodModel>>((ref) async {
  ref.watch(userProvider.select((e) => e?.id));
  return ref.read(moodServiceProvider).getHappyPercentages();
});

final activitiesProvider = FutureProvider<List<String>>((ref) async {
  final latestMood = ref.watch(latestMoodProvider);
  final mood = latestMood.value?.mood;
  final note = latestMood.value?.note;
  return ref.read(aiServiceProvider).recommendActivities(
        mood: mood ?? 'happy',
        note: note,
      );
});
