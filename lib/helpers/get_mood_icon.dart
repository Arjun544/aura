import 'package:aura/utils/moods.dart';

String getMoodIcon(String mood) => moods
    .firstWhere(
      (element) => element.mood.toLowerCase() == mood.toLowerCase(),
      orElse: () => moods.first,
    )
    .emoji;
