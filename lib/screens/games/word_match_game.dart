import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../data/vocabulary.dart';
import '../../models/word.dart';
import '../../services/audio_service.dart';
import '../../services/progress_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/geometric_pattern.dart';

class WordMatchGame extends StatefulWidget {
  const WordMatchGame({super.key});

  @override
  State<WordMatchGame> createState() => _WordMatchGameState();
}

class _WordMatchGameState extends State<WordMatchGame> {
  final _audio = AudioService();
  late List<Word> _words;
  late List<String> _translations;
  String? _selectedArabic;
  String? _selectedUzbek;
  final Set<String> _matched = {};
  int _score = 0;
  int _wrongAttempts = 0;

  @override
  void initState() {
    super.initState();
    _setupRound();
  }

  void _setupRound() {
    final pool = List.of(Vocabulary.beginnerWords)..shuffle();
    _words = pool.take(6).toList();
    _translations = _words.map((w) => w.uzbek).toList()..shuffle();
    _matched.clear();
    _selectedArabic = null;
    _selectedUzbek = null;
  }

  @override
  Widget build(BuildContext context) {
    final allMatched = _matched.length == _words.length;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 8),
              Expanded(
                child: allMatched ? _winView() : _gameView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.emerald),
            onPressed: () => Navigator.maybePop(context),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text('So\'z moslash 🎯',
                      style: AppTheme.uzbekTitle.copyWith(fontSize: 18)),
                  Text('Ball: $_score',
                      style: TextStyle(
                          color: AppColors.emerald,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _gameView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: _words.map((w) {
                final matched = _matched.contains(w.arabic);
                final selected = _selectedArabic == w.arabic;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _MatchTile(
                    text: w.arabic,
                    isArabic: true,
                    matched: matched,
                    selected: selected,
                    onTap: matched ? null : () => _selectArabic(w.arabic),
                    onSpeak: () => _audio.speak(w.arabic),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: _translations.map((t) {
                final matched = _matched.contains(t);
                final selected = _selectedUzbek == t;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _MatchTile(
                    text: t,
                    isArabic: false,
                    matched: matched,
                    selected: selected,
                    onTap: matched ? null : () => _selectUzbek(t),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _selectArabic(String arabic) {
    setState(() => _selectedArabic = arabic);
    _check();
  }

  void _selectUzbek(String uzbek) {
    setState(() => _selectedUzbek = uzbek);
    _check();
  }

  void _check() {
    if (_selectedArabic == null || _selectedUzbek == null) return;
    final word = _words.firstWhere((w) => w.arabic == _selectedArabic);
    if (word.uzbek == _selectedUzbek) {
      setState(() {
        _matched.add(word.arabic);
        _matched.add(word.uzbek);
        _score += 10;
        _selectedArabic = null;
        _selectedUzbek = null;
      });
      context.read<ProgressService>().addXp(5);
    } else {
      _wrongAttempts++;
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _selectedArabic = null;
            _selectedUzbek = null;
          });
        }
      });
    }
  }

  Widget _winView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🏆', style: const TextStyle(fontSize: 96))
              .animate()
              .scale(curve: Curves.elasticOut, duration: 700.ms),
          const SizedBox(height: 16),
          Text('Mukammal!',
              style: AppTheme.uzbekTitle.copyWith(fontSize: 32)),
          const SizedBox(height: 8),
          Text(
            'Xatolar: $_wrongAttempts',
            style: AppTheme.uzbekBody,
          ),
          const SizedBox(height: 24),
          GoldFrame(
            child: Text('+$_score XP',
                style: GoogleFonts.amiri(
                  fontSize: 36,
                  color: AppColors.emerald,
                  fontWeight: FontWeight.bold,
                )),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => setState(() {
              _setupRound();
              _score = 0;
              _wrongAttempts = 0;
            }),
            child: const Text('Yana o\'ynash'),
          ),
        ],
      ),
    );
  }
}

class _MatchTile extends StatelessWidget {
  final String text;
  final bool isArabic;
  final bool matched;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onSpeak;

  const _MatchTile({
    required this.text,
    required this.isArabic,
    required this.matched,
    required this.selected,
    this.onTap,
    this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = AppColors.ivory;
    Color borderColor = AppColors.gold.withOpacity(0.4);
    if (matched) {
      bgColor = AppColors.sage.withOpacity(0.3);
      borderColor = AppColors.emerald;
    } else if (selected) {
      bgColor = AppColors.gold.withOpacity(0.2);
      borderColor = AppColors.gold;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: isArabic
                    ? GoogleFonts.amiri(
                        fontSize: 22,
                        color: AppColors.charcoal,
                        fontWeight: FontWeight.bold,
                      )
                    : AppTheme.uzbekBody.copyWith(fontWeight: FontWeight.w600),
                textDirection:
                    isArabic ? TextDirection.rtl : TextDirection.ltr,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),
            ),
            if (isArabic && onSpeak != null)
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.volume_up,
                    color: AppColors.emerald, size: 18),
                onPressed: onSpeak,
              ),
          ],
        ),
      ),
    );
  }
}
