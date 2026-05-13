import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/progress_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/geometric_pattern.dart';

class _IrabQuestion {
  final String sentence;
  final String word;
  final String correctRole;
  final String explanation;
  final String source;
  const _IrabQuestion({
    required this.sentence,
    required this.word,
    required this.correctRole,
    required this.explanation,
    required this.source,
  });
}

class IrabGame extends StatefulWidget {
  const IrabGame({super.key});

  @override
  State<IrabGame> createState() => _IrabGameState();
}

class _IrabGameState extends State<IrabGame> {
  static const _roles = [
    'Mubtado',
    'Xabar',
    'Fe\'l',
    'Foil',
    'Maf\'ul bih',
    'Majrur',
    'Sifat',
  ];

  // Manba: S. Bekpo'lat — Mabdaun Nahv + M. Hasanov — Arab tili darslari
  // Har bir i'rob tahlili kitobdagi me'yorga muvofiq tekshirilgan
  static const _questions = [
    _IrabQuestion(
      sentence: 'الكِتَابُ جَدِيدٌ',
      word: 'الكِتَابُ',
      correctRole: 'Mubtado',
      explanation:
          'الكِتَابُ — ism, ma\'rifa (الـ), marfu\' (damma). Gap egasi — Mubtado.',
      source: 'Mabdaun Nahv — Jumla ismiyya bobi',
    ),
    _IrabQuestion(
      sentence: 'الكِتَابُ جَدِيدٌ',
      word: 'جَدِيدٌ',
      correctRole: 'Xabar',
      explanation:
          'جَدِيدٌ — nakira (tinvin), marfu\' (damma). Mubtado haqida xabar — Xabar.',
      source: 'Mabdaun Nahv — Xabar bobi',
    ),
    _IrabQuestion(
      sentence: 'كَتَبَ الطَّالِبُ الدَّرْسَ',
      word: 'كَتَبَ',
      correctRole: 'Fe\'l',
      explanation:
          'كَتَبَ — fe\'l mozi, mabniyy \'alal-fatha. O\'tgan zamondagi harakat.',
      source: 'M. Hasanov — Fe\'l bobi',
    ),
    _IrabQuestion(
      sentence: 'كَتَبَ الطَّالِبُ الدَّرْسَ',
      word: 'الطَّالِبُ',
      correctRole: 'Foil',
      explanation:
          'الطَّالِبُ — ism, ma\'rifa, marfu\' (damma). Ishni bajaruvchi — Foil.',
      source: 'Mabdaun Nahv — Foil bobi',
    ),
    _IrabQuestion(
      sentence: 'كَتَبَ الطَّالِبُ الدَّرْسَ',
      word: 'الدَّرْسَ',
      correctRole: 'Maf\'ul bih',
      explanation:
          'الدَّرْسَ — ism, ma\'rifa, mansub (fatha). Ish ob\'ekti — Maf\'ul bih.',
      source: 'Mabdaun Nahv — Maf\'ul bih bobi',
    ),
    _IrabQuestion(
      sentence: 'قَرَأَ المُعَلِّمُ الكِتَابَ',
      word: 'المُعَلِّمُ',
      correctRole: 'Foil',
      explanation:
          'المُعَلِّمُ — marfu\' (damma). O\'qiyotgan shaxs — Foil.',
      source: 'M. Hasanov — Foil bobi',
    ),
    _IrabQuestion(
      sentence: 'البَيْتُ كَبِيرٌ',
      word: 'كَبِيرٌ',
      correctRole: 'Xabar',
      explanation:
          'كَبِيرٌ — sifat-xabar, marfu\' (damma). Mubtadoga mos: muzakkar, mufrad, marfu\'.',
      source: 'M. Hasanov — Sifat-Xabar bobi',
    ),
    _IrabQuestion(
      sentence: 'ذَهَبَ الطَّالِبُ إِلَى المَدْرَسَةِ',
      word: 'المَدْرَسَةِ',
      correctRole: 'Majrur',
      explanation:
          'إِلَى — harf jarr. Undan keyingi ism (المَدْرَسَةِ) majrur (kasra) bo\'ladi. Diqqat: bu Maf\'ul bih emas!',
      source: 'Mabdaun Nahv — Harf jarr bobi',
    ),
    _IrabQuestion(
      sentence: 'الكِتَابُ الجَدِيدُ مُفِيدٌ',
      word: 'الجَدِيدُ',
      correctRole: 'Sifat',
      explanation:
          'الجَدِيدُ — Mubtadoning (الكِتَابُ) sifati. 4 jihatdan mos: ma\'rifa, mufrad, muzakkar, marfu\'.',
      source: 'M. Hasanov — Sifat-Mavsuf bobi',
    ),
  ];

  int _index = 0;
  int _score = 0;
  String? _selected;
  bool _showResult = false;

  @override
  Widget build(BuildContext context) {
    if (_index >= _questions.length) return _winView();
    final q = _questions[_index];

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
                    icon: const Icon(Icons.close, color: AppColors.emerald),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text('I\'rob tahlili 📐',
                              style: AppTheme.uzbekTitle.copyWith(fontSize: 18)),
                          Text('${_index + 1}/${_questions.length} • Ball: $_score',
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
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.emeraldGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text('Gap:',
                        style: TextStyle(
                            color: AppColors.goldLight.withOpacity(0.8))),
                    const SizedBox(height: 8),
                    _HighlightedSentence(
                      sentence: q.sentence,
                      highlightWord: q.word,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.goldLight.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Sariq so\'z qaysi bo\'lak?',
                        style: GoogleFonts.merriweather(
                          color: AppColors.goldLight,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ..._roles.map((role) {
                final isSelected = _selected == role;
                final isCorrect = role == q.correctRole;
                Color borderColor = AppColors.gold.withOpacity(0.4);
                Color bgColor = AppColors.ivory;

                if (_showResult) {
                  if (isCorrect) {
                    borderColor = AppColors.emerald;
                    bgColor = AppColors.sage.withOpacity(0.2);
                  } else if (isSelected) {
                    borderColor = AppColors.deepRed;
                    bgColor = AppColors.deepRed.withOpacity(0.1);
                  }
                } else if (isSelected) {
                  borderColor = AppColors.gold;
                  bgColor = AppColors.gold.withOpacity(0.1);
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: _showResult
                        ? null
                        : () => setState(() => _selected = role),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              role,
                              style: AppTheme.uzbekBody.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (_showResult && isCorrect)
                            const Icon(Icons.check_circle,
                                color: AppColors.emerald),
                          if (_showResult && isSelected && !isCorrect)
                            const Icon(Icons.cancel, color: AppColors.deepRed),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              if (_showResult) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.goldLight.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb, color: AppColors.gold),
                      const SizedBox(width: 8),
                      Expanded(child: Text(q.explanation, style: AppTheme.uzbekBody)),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showResult
                    ? _next
                    : (_selected == null ? null : _check),
                child: Text(_showResult
                    ? (_index < _questions.length - 1 ? 'Keyingisi →' : 'Yakunlash 🎉')
                    : 'Tekshirish'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _check() {
    final correct = _selected == _questions[_index].correctRole;
    if (correct) {
      _score += 10;
      context.read<ProgressService>().addXp(10);
    } else {
      context.read<ProgressService>().loseHeart();
    }
    setState(() => _showResult = true);
  }

  void _next() {
    setState(() {
      _index++;
      _selected = null;
      _showResult = false;
    });
  }

  Widget _winView() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🎓', style: TextStyle(fontSize: 96)),
                const SizedBox(height: 16),
                Text('Tahlil ustasi!',
                    style: AppTheme.uzbekTitle.copyWith(fontSize: 28)),
                const SizedBox(height: 8),
                Text('Yakuniy ball: $_score',
                    style: AppTheme.uzbekBody.copyWith(fontSize: 18)),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _index = 0;
                    _score = 0;
                    _selected = null;
                    _showResult = false;
                  }),
                  child: const Text('Yana o\'ynash'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.maybePop(context),
                  child: const Text('Bosh menyu'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HighlightedSentence extends StatelessWidget {
  final String sentence;
  final String highlightWord;
  const _HighlightedSentence({
    required this.sentence,
    required this.highlightWord,
  });

  @override
  Widget build(BuildContext context) {
    final words = sentence.split(' ');
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      textDirection: TextDirection.rtl,
      children: words.map((w) {
        final highlight = w == highlightWord;
        return Container(
          padding: highlight
              ? const EdgeInsets.symmetric(horizontal: 8, vertical: 2)
              : EdgeInsets.zero,
          decoration: highlight
              ? BoxDecoration(
                  color: AppColors.gold.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.goldLight, width: 1),
                )
              : null,
          child: Text(
            w,
            style: GoogleFonts.amiri(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: highlight ? AppColors.goldLight : AppColors.cream,
            ),
            textDirection: TextDirection.rtl,
          ),
        );
      }).toList(),
    );
  }
}
