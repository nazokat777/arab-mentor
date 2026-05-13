class UserProgress {
  int xp;
  int streak;
  int hearts;
  int gems;
  int level;
  DateTime? lastActivityDate;
  Set<String> completedLessons;
  Map<String, int> lessonScores;
  Set<String> masteredWords;

  UserProgress({
    this.xp = 0,
    this.streak = 0,
    this.hearts = 5,
    this.gems = 100,
    this.level = 1,
    this.lastActivityDate,
    Set<String>? completedLessons,
    Map<String, int>? lessonScores,
    Set<String>? masteredWords,
  })  : completedLessons = completedLessons ?? <String>{},
        lessonScores = lessonScores ?? <String, int>{},
        masteredWords = masteredWords ?? <String>{};

  int get xpForNextLevel => level * 100;
  double get progressToNextLevel => xp / xpForNextLevel;

  Map<String, dynamic> toJson() => {
        'xp': xp,
        'streak': streak,
        'hearts': hearts,
        'gems': gems,
        'level': level,
        'lastActivityDate': lastActivityDate?.toIso8601String(),
        'completedLessons': completedLessons.toList(),
        'lessonScores': lessonScores,
        'masteredWords': masteredWords.toList(),
      };

  factory UserProgress.fromJson(Map<String, dynamic> json) => UserProgress(
        xp: json['xp'] ?? 0,
        streak: json['streak'] ?? 0,
        hearts: json['hearts'] ?? 5,
        gems: json['gems'] ?? 100,
        level: json['level'] ?? 1,
        lastActivityDate: json['lastActivityDate'] != null
            ? DateTime.parse(json['lastActivityDate'])
            : null,
        completedLessons:
            Set<String>.from(json['completedLessons'] ?? <String>[]),
        lessonScores:
            Map<String, int>.from(json['lessonScores'] ?? <String, int>{}),
        masteredWords: Set<String>.from(json['masteredWords'] ?? <String>[]),
      );
}
