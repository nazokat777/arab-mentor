import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_progress.dart';

class ProgressService extends ChangeNotifier {
  static const String _key = 'user_progress';
  late SharedPreferences _prefs;
  UserProgress _progress = UserProgress();

  UserProgress get progress => _progress;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs.getString(_key);
    if (raw != null) {
      _progress = UserProgress.fromJson(jsonDecode(raw));
    }
    _checkStreak();
  }

  Future<void> _save() async {
    await _prefs.setString(_key, jsonEncode(_progress.toJson()));
    notifyListeners();
  }

  void _checkStreak() {
    final now = DateTime.now();
    final last = _progress.lastActivityDate;
    if (last == null) return;
    final daysDiff = now.difference(last).inDays;
    if (daysDiff > 1) {
      _progress.streak = 0;
      _save();
    }
  }

  Future<void> addXp(int amount) async {
    _progress.xp += amount;
    while (_progress.xp >= _progress.xpForNextLevel) {
      _progress.xp -= _progress.xpForNextLevel;
      _progress.level++;
      _progress.gems += 50;
    }
    _updateActivity();
    await _save();
  }

  Future<void> loseHeart() async {
    if (_progress.hearts > 0) _progress.hearts--;
    await _save();
  }

  Future<void> refillHearts() async {
    _progress.hearts = 5;
    await _save();
  }

  Future<void> spendGems(int amount) async {
    if (_progress.gems >= amount) {
      _progress.gems -= amount;
      await _save();
    }
  }

  Future<void> completeLesson(String lessonId, int score) async {
    _progress.completedLessons.add(lessonId);
    _progress.lessonScores[lessonId] = score;
    await addXp(score);
  }

  Future<void> masterWord(String arabic) async {
    _progress.masteredWords.add(arabic);
    await _save();
  }

  void _updateActivity() {
    final now = DateTime.now();
    final last = _progress.lastActivityDate;
    if (last == null) {
      _progress.streak = 1;
    } else {
      final lastDay = DateTime(last.year, last.month, last.day);
      final today = DateTime(now.year, now.month, now.day);
      final diff = today.difference(lastDay).inDays;
      if (diff == 1) {
        _progress.streak++;
      } else if (diff > 1) {
        _progress.streak = 1;
      }
    }
    _progress.lastActivityDate = now;
  }

  Future<void> reset() async {
    _progress = UserProgress();
    await _save();
  }
}
