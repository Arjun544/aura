import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/models/local_mood_model.dart';

final List<MoodModel> moods = [
  MoodModel(
    mood: 'Anger',
    emoji: AssetsManager.angryMood,
    color: Colors.red,
  ),
  MoodModel(
    mood: 'Disgust',
    emoji: AssetsManager.disgustMood,
    color: Colors.purple,
  ),
  MoodModel(
    mood: 'Fear',
    emoji: AssetsManager.fearMood,
    color: Colors.amber,
  ),
  MoodModel(
    mood: 'Joy',
    emoji: AssetsManager.happyMood,
    color: AppColors.successColor,
  ),
  MoodModel(
    mood: 'Neutral',
    emoji: AssetsManager.neutralMood,
    color: Colors.grey,
  ),
  MoodModel(
    mood: 'Sadness',
    emoji: AssetsManager.sadMood,
    color: Colors.orange,
  ),
  MoodModel(
    mood: 'Surprise',
    emoji: AssetsManager.surpriseMood,
    color: Colors.blue,
  ),
];
