import 'package:aura/utils/moods.dart';

String getMoodIcon(String mood) => localMoods
    .firstWhere(
      (element) => element.mood.toLowerCase() == mood.toLowerCase(),
      orElse: () => localMoods.first,
    )
    .emoji;
