import 'package:aura/core/assets_manager.dart';
import 'package:aura/models/mood_model.dart';

final List<MoodModel> moods = [
  MoodModel(mood: 'Joy', emoji: AssetsManager.happyMood),
  MoodModel(mood: 'Sadness', emoji: AssetsManager.sadMood),
  MoodModel(mood: 'Anger', emoji: AssetsManager.angryMood),
  MoodModel(mood: 'Surprise', emoji: AssetsManager.surpriseMood),
  MoodModel(mood: 'Disgust', emoji: AssetsManager.disgustMood),
  MoodModel(mood: 'Love', emoji: AssetsManager.loveMood),
  MoodModel(mood: 'Contentment', emoji: AssetsManager.contentmentMood),
  MoodModel(mood: 'Boredom', emoji: AssetsManager.boreMood),
  MoodModel(mood: 'Confidence', emoji: AssetsManager.confidenceMood),
];
