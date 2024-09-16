import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:aura/services/mood_service.dart';

final dayMoodProvider =
    FutureProvider.family<MoodModel, String>((ref, date) async {
  ref.watch(userProvider.select((e) => e?.id));
  return ref.read(moodServiceProvider).getMoodByDate(date: date);
});

final happyPercentageProvider = FutureProvider<double>((ref) async {
  ref.watch(userProvider.select((e) => e?.id));
  return ref.read(moodServiceProvider).getHappyPercentage();
});
