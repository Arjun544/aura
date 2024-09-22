import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/models/local_mood_model.dart';

final List<LocalMoodModel> localMoods = [
  LocalMoodModel(
    mood: 'Anger',
    emoji: AssetsManager.angryMood,
    color: Colors.red,
  ),
  LocalMoodModel(
    mood: 'Disgust',
    emoji: AssetsManager.disgustMood,
    color: Colors.purple,
  ),
  LocalMoodModel(
    mood: 'Fear',
    emoji: AssetsManager.fearMood,
    color: Colors.amber,
  ),
  LocalMoodModel(
    mood: 'Happy',
    emoji: AssetsManager.happyMood,
    color: AppColors.successColor,
  ),
  LocalMoodModel(
    mood: 'Neutral',
    emoji: AssetsManager.neutralMood,
    color: Colors.grey,
  ),
  LocalMoodModel(
    mood: 'Sad',
    emoji: AssetsManager.sadMood,
    color: Colors.orange,
  ),
  LocalMoodModel(
    mood: 'Surprise',
    emoji: AssetsManager.surpriseMood,
    color: Colors.blue,
  ),
];
