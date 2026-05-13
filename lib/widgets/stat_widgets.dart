import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class StreakBadge extends StatelessWidget {
  final int streak;
  const StreakBadge({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFFA07A)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 16))
              .animate(onPlay: (c) => c.repeat())
              .scale(
                duration: 800.ms,
                begin: const Offset(1, 1),
                end: const Offset(1.15, 1.15),
              )
              .then()
              .scale(
                duration: 800.ms,
                begin: const Offset(1.15, 1.15),
                end: const Offset(1, 1),
              ),
          const SizedBox(width: 4),
          Text(
            '$streak',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class HeartsBadge extends StatelessWidget {
  final int hearts;
  const HeartsBadge({super.key, required this.hearts});

  @override
  Widget build(BuildContext context) {
    return _statBadge(
      icon: '❤️',
      value: '$hearts',
      color: const Color(0xFFE63946),
    );
  }
}

class GemsBadge extends StatelessWidget {
  final int gems;
  const GemsBadge({super.key, required this.gems});

  @override
  Widget build(BuildContext context) {
    return _statBadge(
      icon: '💎',
      value: '$gems',
      color: const Color(0xFF1D9BF0),
    );
  }
}

Widget _statBadge({required String icon, required String value, required Color color}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.ivory,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(icon, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

class LevelProgressBar extends StatelessWidget {
  final int level;
  final double progress;
  final int xp;
  final int xpForNext;

  const LevelProgressBar({
    super.key,
    required this.level,
    required this.progress,
    required this.xp,
    required this.xpForNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Daraja $level',
                style: const TextStyle(
                  color: AppColors.softBrown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '$xp / $xpForNext XP',
              style: const TextStyle(
                color: AppColors.charcoal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 12,
            backgroundColor: AppColors.sage.withOpacity(0.2),
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.emerald),
          ),
        ),
      ],
    );
  }
}
