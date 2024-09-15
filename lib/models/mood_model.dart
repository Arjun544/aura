import 'dart:convert';

class MoodModel {
  final String? mood;
  final double? score;
  final List<Emotion>? emotions;

  MoodModel({
    this.mood,
    this.score,
    this.emotions,
  });

  MoodModel copyWith({
    String? mood,
    double? score,
    List<Emotion>? emotions,
  }) =>
      MoodModel(
        mood: mood ?? this.mood,
        score: score ?? this.score,
        emotions: emotions ?? this.emotions,
      );

  factory MoodModel.fromRawJson(String str) =>
      MoodModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoodModel.fromJson(Map<String, dynamic> json) => MoodModel(
        mood: json["mood"],
        score: json["score"]?.toDouble(),
        emotions: json["emotions"] == null
            ? []
            : List<Emotion>.from(
                json["emotions"]!.map((x) => Emotion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mood": mood,
        "score": score,
        "emotions": emotions == null
            ? []
            : List<dynamic>.from(emotions!.map((x) => x.toJson())),
      };
}

class Emotion {
  final String? label;
  final double? score;

  Emotion({
    this.label,
    this.score,
  });

  Emotion copyWith({
    String? label,
    double? score,
  }) =>
      Emotion(
        label: label ?? this.label,
        score: score ?? this.score,
      );

  factory Emotion.fromRawJson(String str) => Emotion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Emotion.fromJson(Map<String, dynamic> json) => Emotion(
        label: json["label"],
        score: json["score"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "score": score,
      };
}
