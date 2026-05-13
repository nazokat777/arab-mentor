import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/achievements_data.dart';
import '../models/achievement.dart';
import '../services/haptic_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/geometric_pattern.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>().progress;
    final achievements = AchievementsData.all;

    final unlocked = achievements
        .where((a) => a.currentValue(progress) >= a.target)
        .length;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.emerald),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const SizedBox(width: 8),
                  Text('Yutuqlar 🏆', style: AppTheme.uzbekTitle),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.emeraldGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text('🏆', style: const TextStyle(fontSize: 36))
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(
                            duration: 1200.ms,
                            begin: const Offset(1, 1),
                            end: const Offset(1.1, 1.1)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$unlocked / ${achievements.length}',
                            style: GoogleFonts.amiri(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldLight,
                            ),
                          ),
                          Text('Ochilgan yutuqlar',
                              style: GoogleFonts.merriweather(
                                color: AppColors.cream,
                                fontSize: 13,
                              )),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: unlocked / achievements.length,
                              minHeight: 8,
                              backgroundColor:
                                  AppColors.goldLight.withOpacity(0.2),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.goldLight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ...achievements.asMap().entries.map((e) {
                final a = e.value;
                final current = a.currentValue(progress);
                final unlocked = current >= a.target;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _AchievementCard(
                    achievement: a,
                    current: current,
                    unlocked: unlocked,
                  ),
                )
                    .animate(delay: (e.key * 60).ms)
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: 0.1);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final int current;
  final bool unlocked;
  const _AchievementCard({
    required this.achievement,
    required this.current,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unlocked ? Haptics.celebrate : Haptics.tap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.ivory,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: unlocked ? achievement.color : AppColors.gold.withOpacity(0.3),
            width: unlocked ? 2.5 : 1,
          ),
          boxShadow: unlocked
              ? [
                  BoxShadow(
                    color: achievement.color.withOpacity(0.3),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: unlocked
                    ? LinearGradient(
                        colors: [
                          achievement.color,
                          achievement.color.withOpacity(0.6),
                        ],
                      )
                    : null,
                color: unlocked ? null : AppColors.sage.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  unlocked ? achievement.emoji : '🔒',
                  style: TextStyle(
                    fontSize: unlocked ? 32 : 24,
                    color: unlocked ? null : AppColors.softBrown,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: AppTheme.uzbekBody.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color:
                          unlocked ? AppColors.emerald : AppColors.charcoal,
                    ),
                  ),
                  Text(achievement.description,
                      style: AppTheme.uzbekBody.copyWith(fontSize: 12)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value:
                                (current / achievement.target).clamp(0.0, 1.0),
                            minHeight: 6,
                            backgroundColor:
                                AppColors.sage.withOpacity(0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                achievement.color),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$current/${achievement.target}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: unlocked
                              ? achievement.color
                              : AppColors.softBrown,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '+${achievement.xpReward}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.softBrown,
                    ),
                  ),
                ),
                const Text('XP',
                    style: TextStyle(
                        fontSize: 9, color: AppColors.softBrown)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
