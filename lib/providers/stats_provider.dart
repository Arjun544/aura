

import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/models/mood_model.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:aura/services/stats_service.dart';

final statsProvider = FutureProvider<List<MoodModel>>((ref) async {
  ref.watch(userProvider.select((e) => e?.id));
  return ref.read(statsServiceProvider).getPercentageByMood();
});