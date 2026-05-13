import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../data/vocabulary.dart';
import '../models/word.dart';
import '../services/audio_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/geometric_pattern.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final _audio = AudioService();
  late List<Word> _deck;
  int _index = 0;
  int _learned = 0;
  bool _flipped = false;

  @override
  void initState() {
    super.initState();
    _deck = List.of(Vocabulary.beginnerWords)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (_index >= _deck.length) return _finishedView();

    final card = _deck[_index];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: _FlipCard(
                      key: ValueKey(_index),
                      front: _front(card),
                      back: _back(card),
                      flipped: _flipped,
                      onTap: () => setState(() => _flipped = !_flipped),
                    ),
                  ),
                ),
              ),
              _buildSwipeButtons(card),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final progress = (_index) / _deck.length;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.emerald),
                onPressed: () => Navigator.maybePop(context),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Kartochkalar 🎴',
                    style: AppTheme.uzbekTitle.copyWith(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                width: 48,
                child: Text(
                  '${_index + 1}/${_deck.length}',
                  style: AppTheme.uzbekBody.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.emerald,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.sage.withOpacity(0.2),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.emerald),
            ),
          ),
        ],
      ),
    );
  }

  Widget _front(Word w) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.emeraldGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.emerald.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.volume_up,
                  color: AppColors.goldLight, size: 32),
              onPressed: () => _audio.speak(w.arabic),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  w.arabic,
                  style: GoogleFonts.amiri(
                    fontSize: 64,
                    color: AppColors.goldLight,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 12),
                Text(
                  w.transliteration,
                  style: GoogleFonts.merriweather(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: AppColors.cream,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.goldLight.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.touch_app,
                          color: AppColors.goldLight, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'Tarjimani ko\'rish uchun bosing',
                        style: GoogleFonts.merriweather(
                          color: AppColors.goldLight,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _back(Word w) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.gold, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(w.uzbek,
                style: AppTheme.uzbekTitle.copyWith(fontSize: 32),
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.emerald.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                w.typeUzbek,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.emerald,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (w.root != null) ...[
              const SizedBox(height: 16),
              const OrnamentDivider(),
              Text('O\'zak:',
                  style: AppTheme.uzbekBody.copyWith(fontSize: 12)),
              Text(w.root!,
                  style: GoogleFonts.amiri(
                    fontSize: 24,
                    color: AppColors.softBrown,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl),
            ],
            if (w.plural != null) ...[
              const SizedBox(height: 12),
              Text('Ko\'pligi:',
                  style: AppTheme.uzbekBody.copyWith(fontSize: 12)),
              Text(w.plural!,
                  style: GoogleFonts.amiri(
                    fontSize: 22,
                    color: AppColors.emerald,
                  ),
                  textDirection: TextDirection.rtl),
            ],
            if (w.exampleSentence != null) ...[
              const SizedBox(height: 16),
              const OrnamentDivider(),
              Text(w.exampleSentence!,
                  style: GoogleFonts.amiri(
                    fontSize: 20,
                    color: AppColors.charcoal,
                  ),
                  textDirection: TextDirection.rtl),
              if (w.exampleTranslation != null)
                Text(
                  w.exampleTranslation!,
                  style: GoogleFonts.merriweather(
                    fontStyle: FontStyle.italic,
                    color: AppColors.softBrown,
                    fontSize: 13,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeButtons(Word card) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ActionButton(
            icon: Icons.refresh,
            color: AppColors.deepRed,
            label: 'Qaytadan',
            onTap: () => _next(card, learned: false),
          ),
          _ActionButton(
            icon: Icons.check,
            color: AppColors.emerald,
            label: 'Bilaman',
            primary: true,
            onTap: () => _next(card, learned: true),
          ),
        ],
      ),
    );
  }

  void _next(Word card, {required bool learned}) {
    if (learned) {
      _learned++;
      context.read<ProgressService>().masterWord(card.arabic);
      context.read<ProgressService>().addXp(5);
    }
    setState(() {
      _flipped = false;
      _index++;
    });
  }

  Widget _finishedView() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('🎉', style: const TextStyle(fontSize: 80))
                    .animate()
                    .scale(curve: Curves.elasticOut, duration: 600.ms),
                const SizedBox(height: 16),
                Text('Ajoyib!',
                    style: AppTheme.uzbekTitle.copyWith(fontSize: 32)),
                Text('$_learned / ${_deck.length} so\'z o\'rgandingiz',
                    style: AppTheme.uzbekBody.copyWith(fontSize: 18)),
                const SizedBox(height: 32),
                GoldFrame(
                  child: Text('+${_learned * 5} XP',
                      style: GoogleFonts.amiri(
                        fontSize: 36,
                        color: AppColors.emerald,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _deck = List.of(Vocabulary.beginnerWords)..shuffle();
                      _index = 0;
                      _learned = 0;
                      _flipped = false;
                    });
                  },
                  child: const Text('Yana mashq qilish'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.maybePop(context),
                  child: const Text('Bosh menyuga'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FlipCard extends StatelessWidget {
  final Widget front;
  final Widget back;
  final bool flipped;
  final VoidCallback onTap;
  const _FlipCard({
    super.key,
    required this.front,
    required this.back,
    required this.flipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: flipped ? 1 : 0),
        duration: const Duration(milliseconds: 500),
        builder: (context, value, child) {
          final angle = value * math.pi;
          final isBack = value > 0.5;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: SizedBox(
              width: double.infinity,
              height: 420,
              child: isBack
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(math.pi),
                      child: back,
                    )
                  : front,
            ),
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  final bool primary;
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: primary
                  ? LinearGradient(colors: [color, color.withOpacity(0.7)])
                  : null,
              color: primary ? null : AppColors.ivory,
              shape: BoxShape.circle,
              border: primary ? null : Border.all(color: color, width: 2),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: primary ? Colors.white : color, size: 32),
          ),
          const SizedBox(height: 6),
          Text(label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
