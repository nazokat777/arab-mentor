import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

enum MascotMood { happy, thinking, celebrating, sleeping, encouraging }

class Mascot extends StatelessWidget {
  final MascotMood mood;
  final String? speech;
  final double size;

  const Mascot({
    super.key,
    this.mood = MascotMood.happy,
    this.speech,
    this.size = 80,
  });

  String get _emoji {
    switch (mood) {
      case MascotMood.happy:
        return '🦉';
      case MascotMood.thinking:
        return '🤔';
      case MascotMood.celebrating:
        return '🎉';
      case MascotMood.sleeping:
        return '😴';
      case MascotMood.encouraging:
        return '💪';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mascot = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.goldLight, AppColors.gold],
        ),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.emerald, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.4),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(_emoji, style: TextStyle(fontSize: size * 0.5)),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          duration: 1800.ms,
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
        );

    if (speech == null) return mascot;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        mascot,
        const SizedBox(width: 12),
        Flexible(
          child: _SpeechBubble(text: speech!),
        ),
      ],
    );
  }
}

class _SpeechBubble extends StatelessWidget {
  final String text;
  const _SpeechBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.emerald.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.merriweather(
          color: AppColors.charcoal,
          fontSize: 13,
          height: 1.4,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideX(begin: -0.1, end: 0, duration: 400.ms);
  }
}
