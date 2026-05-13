import 'package:flutter/services.dart';

class Haptics {
  static Future<void> tap() => HapticFeedback.lightImpact();
  static Future<void> click() => HapticFeedback.selectionClick();
  static Future<void> success() async {
    await HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 80));
    await HapticFeedback.lightImpact();
  }
  static Future<void> error() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }
  static Future<void> warning() => HapticFeedback.mediumImpact();
  static Future<void> celebrate() async {
    for (int i = 0; i < 3; i++) {
      await HapticFeedback.lightImpact();
      await Future.delayed(const Duration(milliseconds: 60));
    }
    await HapticFeedback.mediumImpact();
  }
}
