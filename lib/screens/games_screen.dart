import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/geometric_pattern.dart';
import 'games/word_match_game.dart';
import 'games/sentence_builder_game.dart';
import 'games/irab_game.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    icon: const Icon(Icons.arrow_back, color: AppColors.emerald),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const SizedBox(width: 8),
                  Text('O\'yinlar 🎮', style: AppTheme.uzbekTitle),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'O\'rganganlaringni mustahkamla!',
                style: AppTheme.uzbekBody.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 24),
              _GameCard(
                emoji: '🎯',
                title: 'So\'z moslash',
                subtitle: 'Arabcha so\'zni o\'zbekcha tarjimasiga ulang',
                difficulty: 'Oson',
                gradient: AppColors.emeraldGradient,
                onTap: () => _open(context, const WordMatchGame()),
              ),
              const SizedBox(height: 12),
              _GameCard(
                emoji: '🧩',
                title: 'Gap yasash',
                subtitle: 'So\'zlarni to\'g\'ri tartibga keltir',
                difficulty: 'O\'rta',
                gradient: AppColors.goldGradient,
                onTap: () => _open(context, const SentenceBuilderGame()),
              ),
              const SizedBox(height: 12),
              _GameCard(
                emoji: '📐',
                title: 'I\'rob tahlili',
                subtitle: 'Gap bo\'laklarini aniqla (Mubtado, Xabar, ...)',
                difficulty: 'Qiyin',
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B2331), Color(0xFFB85450)],
                ),
                onTap: () => _open(context, const IrabGame()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}

class _GameCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String difficulty;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const _GameCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.difficulty,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: gradient.colors.first.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 48)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.merriweather(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.merriweather(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        difficulty,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1),
    );
  }
}
