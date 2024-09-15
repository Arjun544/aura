import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/models/local_mood_model.dart';

final List<MoodModel> moods = [
  MoodModel(
    mood: 'Joy',
    emoji: AssetsManager.happyMood,
    color: AppColors.successColor,
  ),
  MoodModel(
    mood: 'Sadness',
    emoji: AssetsManager.sadMood,
    color: Colors.orange,
  ),
  MoodModel(
    mood: 'Anger',
    emoji: AssetsManager.angryMood,
    color: Colors.red,
  ),
  MoodModel(
    mood: 'Surprise',
    emoji: AssetsManager.surpriseMood,
    color: Colors.blue,
  ),
  MoodModel(
    mood: 'Disgust',
    emoji: AssetsManager.disgustMood,
    color: Colors.purple,
  ),
  MoodModel(
    mood: 'Love',
    emoji: AssetsManager.loveMood,
    color: Colors.pink,
  ),
  MoodModel(
    mood: 'Contentment',
    emoji: AssetsManager.contentmentMood,
    color: AppColors.successColor,
  ),
  MoodModel(
    mood: 'Boredom',
    emoji: AssetsManager.boreMood,
    color: Colors.orange,
  ),
  MoodModel(
    mood: 'Confidence',
    emoji: AssetsManager.confidenceMood,
    color: AppColors.primary,
  ),
];
