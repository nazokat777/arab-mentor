import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/lessons_data.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/geometric_pattern.dart';
import '../widgets/stat_widgets.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<ProgressService>();
    final p = service.progress;
    final completionRate = LessonsData.allLessons.isEmpty
        ? 0.0
        : p.completedLessons.length / LessonsData.allLessons.length;

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
                  Expanded(child: Text('Profil', style: AppTheme.uzbekTitle)),
                  IconButton(
                    icon: const Icon(Icons.settings, color: AppColors.emerald),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SettingsScreen()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: AppColors.emeraldGradient,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.gold, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gold.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${p.level}',
                          style: GoogleFonts.amiri(
                            color: AppColors.goldLight,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ).animate().scale(curve: Curves.elasticOut, duration: 600.ms),
                    const SizedBox(height: 12),
                    Text('Daraja ${p.level}',
                        style: AppTheme.uzbekTitle.copyWith(fontSize: 22)),
                    Text('Talib (طالب)',
                        style: GoogleFonts.amiri(
                          fontSize: 16,
                          color: AppColors.softBrown,
                          fontStyle: FontStyle.italic,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GoldFrame(
                child: LevelProgressBar(
                  level: p.level,
                  progress: p.progressToNextLevel,
                  xp: p.xp,
                  xpForNext: p.xpForNextLevel,
                ),
              ),
              const SizedBox(height: 20),
              Text('Statistika 📊',
                  style: AppTheme.uzbekTitle.copyWith(fontSize: 18)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: '🔥',
                      value: '${p.streak}',
                      label: 'Kunlik streak',
                      color: const Color(0xFFFF6B35),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: '❤️',
                      value: '${p.hearts}',
                      label: 'Yurakcha',
                      color: const Color(0xFFE63946),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: '💎',
                      value: '${p.gems}',
                      label: 'Gavhar',
                      color: const Color(0xFF1D9BF0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: '📖',
                      value: '${p.masteredWords.length}',
                      label: 'O\'rgangan so\'z',
                      color: AppColors.emerald,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('O\'rganish jarayoni 🎯',
                  style: AppTheme.uzbekTitle.copyWith(fontSize: 18)),
              const SizedBox(height: 12),
              GoldFrame(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tugatilgan darslar',
                            style: AppTheme.uzbekBody),
                        Text(
                            '${p.completedLessons.length} / ${LessonsData.allLessons.length}',
                            style: AppTheme.uzbekBody.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.emerald)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: completionRate,
                        minHeight: 10,
                        backgroundColor: AppColors.sage.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.emerald),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const OrnamentDivider(),
              Center(
                child: Text(
                  'وَقُل رَّبِّ زِدْنِي عِلْمًا',
                  style: GoogleFonts.amiri(
                    fontSize: 18,
                    color: AppColors.softBrown,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              const SizedBox(height: 24),
              const _MnsmCredit(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

}

class _MnsmCredit extends StatelessWidget {
  const _MnsmCredit();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A1A), Color(0xFF0A0A0A)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFC0C0C0).withOpacity(0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC0C0C0).withOpacity(0.15),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'DEVELOPED BY',
            style: GoogleFonts.merriweather(
              fontSize: 10,
              letterSpacing: 4,
              color: const Color(0xFFC0C0C0).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 70,
            child: Image.asset(
              'assets/images/mnsm_logo.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Center(
                child: ShaderMask(
                  shaderCallback: (rect) => const LinearGradient(
                    colors: [
                      Color(0xFFE8E8E8),
                      Color(0xFFC0C0C0),
                      Color(0xFF888888),
                      Color(0xFFE8E8E8),
                    ],
                  ).createShader(rect),
                  child: Text(
                    'MNSM',
                    style: GoogleFonts.cinzel(
                      fontSize: 36,
                      letterSpacing: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'AI SPECIALIST',
            style: GoogleFonts.merriweather(
              fontSize: 11,
              letterSpacing: 5,
              color: const Color(0xFFC0C0C0),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Artificial Intelligence Solutions',
            style: GoogleFonts.merriweather(
              fontSize: 9,
              letterSpacing: 1,
              fontStyle: FontStyle.italic,
              color: const Color(0xFFC0C0C0).withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Text(value,
              style: GoogleFonts.amiri(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              )),
          Text(label,
              style: AppTheme.uzbekBody.copyWith(fontSize: 12),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
