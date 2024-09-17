import 'dart:convert';

class MoodModel {
  final String? id;
  final String? mood;
  final String? note;
  final double? score;
  final List<Emotion>? emotions;
  final DateTime? createdAt;

  MoodModel({
    this.id,
    this.mood,
    this.note,
    this.score,
    this.emotions,
    this.createdAt,
  });

  MoodModel copyWith({
    String? id,
    String? mood,
    String? note,
    double? score,
    List<Emotion>? emotions,
    DateTime? createdAt,
  }) =>
      MoodModel(
        id: id ?? this.id,
        mood: mood ?? this.mood,
        note: note ?? this.note,
        score: score ?? this.score,
        emotions: emotions ?? this.emotions,
        createdAt: createdAt ?? this.createdAt,
      );

  factory MoodModel.fromRawJson(String str) =>
      MoodModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoodModel.fromJson(Map<String, dynamic> json) => MoodModel(
        id: json["id"],
        mood: json["mood"] == 'joy' ? 'happy' : json["mood"],
        note: json["note"],
        score: json["score"]?.toDouble(),
        emotions: json["mood_data"] == null
            ? []
            : List<Emotion>.from(
                json["mood_data"]!.map((x) => Emotion.fromJson(x)),
              ),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "mood": mood,
        "note": note,
        "score": score,
        "mood_data": emotions == null
            ? []
            : List<dynamic>.from(
                emotions!.map((x) => x.toJson()),
              ),
        "created_at": createdAt!.toUtc().toLocal().toString(),
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
        label: json["label"] == 'joy' ? 'happy' : json["label"],
        score: json["score"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "score": score,
      };
}
