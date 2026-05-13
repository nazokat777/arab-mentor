import 'package:flutter/material.dart';

class Achievement {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final Color color;
  final int xpReward;
  final int Function(dynamic progress) currentValue;
  final int target;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.color,
    required this.xpReward,
    required this.currentValue,
    required this.target,
  });
}
