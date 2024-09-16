import 'dart:convert';

class StreakModel {
  final String? id;
  final String? userId;
  final int? streakCount;
  final int? longestStreak;
  final DateTime? lastMoodDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<DateTime>? streakDates;

  StreakModel({
    this.id,
    this.userId,
    this.streakCount,
    this.longestStreak,
    this.lastMoodDate,
    this.createdAt,
    this.updatedAt,
    this.streakDates,
  });

  StreakModel copyWith({
    String? id,
    String? userId,
    int? streakCount,
    int? longestStreak,
    DateTime? lastMoodDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<DateTime>? streakDates,
  }) =>
      StreakModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        streakCount: streakCount ?? this.streakCount,
        longestStreak: longestStreak ?? this.longestStreak,
        lastMoodDate: lastMoodDate ?? this.lastMoodDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        streakDates: streakDates ?? this.streakDates,
      );

  factory StreakModel.fromRawJson(String str) =>
      StreakModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StreakModel.fromJson(Map<String, dynamic> json) => StreakModel(
        id: json["id"],
        userId: json["user_id"],
        streakCount: json["streak_count"],
        longestStreak: json["longest_streak"],
        lastMoodDate: json["last_mood_date"] == null
            ? null
            : DateTime.parse(json["last_mood_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        streakDates: json["streak_dates"] == null
            ? []
            : List<DateTime>.from(
                json["streak_dates"]!.map((x) => DateTime.parse(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "streak_count": streakCount,
        "longest_streak": longestStreak,
        "last_mood_date":
            "${lastMoodDate!.year.toString().padLeft(4, '0')}-${lastMoodDate!.month.toString().padLeft(2, '0')}-${lastMoodDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "streak_dates": streakDates == null
            ? []
            : List<dynamic>.from(streakDates!.map((x) =>
                "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
      };
}
