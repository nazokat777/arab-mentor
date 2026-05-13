import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../../services/audio_service.dart';
import '../../services/haptic_service.dart';
import '../../services/progress_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/geometric_pattern.dart';
import '../../widgets/mascot.dart';

class _AyahTask {
  final String ayah;
  final String surah;
  final String translation;
  final List<_TokenInfo> tokens;
  const _AyahTask({
    required this.ayah,
    required this.surah,
    required this.translation,
    required this.tokens,
  });
}

class _TokenInfo {
  final String word;
  final String role; // grammatical role (correct answer)
  final String explanation;
  const _TokenInfo(this.word, this.role, this.explanation);
}

class QuranAnalysisGame extends StatefulWidget {
  const QuranAnalysisGame({super.key});

  @override
  State<QuranAnalysisGame> createState() => _QuranAnalysisGameState();
}

class _QuranAnalysisGameState extends State<QuranAnalysisGame> {
  final _audio = AudioService();
  late ConfettiController _confetti;

  static const _roles = [
    'Mubtado',
    'Xabar',
    'Fe\'l',
    'Foil',
    'Maf\'ul bih',
    'Harf jarr',
    'Majrur',
    'Muzof',
    'Muzof ilayh',
    'Sifat',
  ];

  // Manba: S. Bekpo'lat — Mabdaun Nahv (tahlilli misollar)
  // Barcha oyatlar Madina mushafi rivoyatiga ko'ra yozilgan
  static const _tasks = [
    _AyahTask(
      ayah: 'الْحَمْدُ لِلَّهِ',
      surah: 'Fotiha: 2 (1-qism)',
      translation: 'Alloh uchun hamd (maqtov)',
      tokens: [
        _TokenInfo('الْحَمْدُ', 'Mubtado',
            'الْحَمْدُ — Mubtado, marfu\' (damma). Aniq ism (الـ bilan). Manba: Mabdaun Nahv, jumla ismiya bobi.'),
        _TokenInfo('لِلَّهِ', 'Harf jarr',
            'لِ — harf jarr (uchun), اللَّهِ — majrur. "Jarr va majrur" Xabar o\'rnida (mahallan marfu\').'),
      ],
    ),
    _AyahTask(
      ayah: 'رَبِّ الْعَالَمِينَ',
      surah: 'Fotiha: 2 (2-qism)',
      translation: 'Olamlarning Robbi',
      tokens: [
        _TokenInfo('رَبِّ', 'Muzof',
            'رَبِّ — Muzof, kasra bilan (لِلَّهِ ga sifat — majrur). Izafatning birinchi qismi.'),
        _TokenInfo('الْعَالَمِينَ', 'Muzof ilayh',
            'الْعَالَمِينَ — Muzof ilayh, majrur (ya — jam\' muzakkar solim alomati).'),
      ],
    ),
    _AyahTask(
      ayah: 'إِيَّاكَ نَعْبُدُ',
      surah: 'Fotiha: 5 (1-qism)',
      translation: 'Faqat Senga ibodat qilamiz',
      tokens: [
        _TokenInfo('إِيَّاكَ', 'Maf\'ul bih',
            'إِيَّا — munfasil mansub zamir, كَ — xitob. Maf\'ul bih bo\'lib, ta\'qiq uchun gap boshiga keltirilgan (taqdim).'),
        _TokenInfo('نَعْبُدُ', 'Fe\'l',
            'نَعْبُدُ — fe\'l muzore\', marfu\'. Foil — yashirin zamir (نَحْنُ).'),
      ],
    ),
    _AyahTask(
      ayah: 'وَإِيَّاكَ نَسْتَعِينُ',
      surah: 'Fotiha: 5 (2-qism)',
      translation: 'Va faqat Sendan yordam so\'raymiz',
      tokens: [
        _TokenInfo('إِيَّاكَ', 'Maf\'ul bih',
            'إِيَّاكَ — mansub munfasil zamir, taqdim qilingan maf\'ul bih.'),
        _TokenInfo('نَسْتَعِينُ', 'Fe\'l',
            'نَسْتَعِينُ — fe\'l muzore\', marfu\'. Foil yashirin (نَحْنُ).'),
      ],
    ),
    _AyahTask(
      ayah: 'قُلْ هُوَ اللَّهُ أَحَدٌ',
      surah: 'Ixlos: 1',
      translation: 'Aytgil: U — Alloh — yagonadir',
      tokens: [
        _TokenInfo('هُوَ', 'Mubtado',
            'هُوَ — munfasil marfu\' zamir, Mubtado.'),
        _TokenInfo('اللَّهُ', 'Xabar',
            'اللَّهُ — Mubtadoning Xabari, marfu\' (damma).'),
        _TokenInfo('أَحَدٌ', 'Xabar',
            'أَحَدٌ — ikkinchi Xabar (yoki هُوَ ning ikkinchi xabari). Marfu\'.'),
      ],
    ),
    _AyahTask(
      ayah: 'اللَّهُ الصَّمَدُ',
      surah: 'Ixlos: 2',
      translation: 'Alloh — Somad (Beniyoz)',
      tokens: [
        _TokenInfo('اللَّهُ', 'Mubtado',
            'اللَّهُ — Mubtado, marfu\' (damma).'),
        _TokenInfo('الصَّمَدُ', 'Xabar',
            'الصَّمَدُ — Xabar, marfu\'. Aniq (الـ bilan).'),
      ],
    ),
  ];

  int _taskIndex = 0;
  int _tokenIndex = 0;
  int _score = 0;
  String? _selected;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_taskIndex >= _tasks.length) return _winView();

    final task = _tasks[_taskIndex];
    final currentToken = task.tokens[_tokenIndex];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildAyahCard(task, currentToken),
                        const SizedBox(height: 20),
                        _buildQuestion(currentToken),
                        const SizedBox(height: 16),
                        _buildOptions(currentToken),
                        if (_showResult) ...[
                          const SizedBox(height: 16),
                          _buildFeedback(currentToken),
                        ],
                        const SizedBox(height: 16),
                        _buildAction(task),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  numberOfParticles: 25,
                  colors: const [
                    AppColors.gold,
                    AppColors.emerald,
                    AppColors.goldLight,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final task = _tasks[_taskIndex];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.emerald),
            onPressed: () {
              Haptics.tap();
              Navigator.maybePop(context);
            },
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text('Qur\'on tahlili 📖',
                      style: AppTheme.uzbekTitle.copyWith(fontSize: 17)),
                  Text(
                      'Oyat ${_taskIndex + 1}/${_tasks.length} • So\'z ${_tokenIndex + 1}/${task.tokens.length}',
                      style: AppTheme.uzbekBody.copyWith(fontSize: 11)),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('$_score XP',
                style: TextStyle(
                    color: AppColors.softBrown,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildAyahCard(_AyahTask task, _TokenInfo currentToken) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.emeraldGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.emerald.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHighlightedAyah(task.ayah, currentToken.word),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: AppColors.goldLight.withOpacity(0.3),
          ),
          const SizedBox(height: 12),
          Text(
            '"${task.translation}"',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontStyle: FontStyle.italic,
              color: AppColors.cream,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bookmark,
                  color: AppColors.goldLight.withOpacity(0.7), size: 14),
              const SizedBox(width: 4),
              Text(
                task.surah,
                style: GoogleFonts.merriweather(
                  color: AppColors.goldLight.withOpacity(0.8),
                  fontSize: 11,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Haptics.click();
                  _audio.speak(task.ayah);
                },
                child: const Icon(Icons.volume_up,
                    color: AppColors.goldLight, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedAyah(String ayah, String highlightWord) {
    final words = ayah.split(' ');
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 4,
      textDirection: TextDirection.rtl,
      children: words.map((w) {
        final highlight = w == highlightWord;
        return Container(
          padding: highlight
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 4)
              : const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: highlight
              ? BoxDecoration(
                  color: AppColors.gold.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.goldLight,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.4),
                      blurRadius: 8,
                    ),
                  ],
                )
              : null,
          child: Text(
            w,
            style: GoogleFonts.amiri(
              fontSize: highlight ? 32 : 28,
              fontWeight: FontWeight.bold,
              color: highlight ? AppColors.goldLight : AppColors.cream,
            ),
            textDirection: TextDirection.rtl,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuestion(_TokenInfo token) {
    return Mascot(
      mood: MascotMood.thinking,
      speech:
          'Sariq ramka ichidagi "${token.word}" so\'zining gapdagi vazifasi nima?',
      size: 70,
    );
  }

  Widget _buildOptions(_TokenInfo token) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _roles.map((role) {
        final isSelected = _selected == role;
        final isCorrect = role == token.role;
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
          bgColor = AppColors.gold.withOpacity(0.15);
        }

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _showResult
              ? null
              : () {
                  Haptics.click();
                  setState(() => _selected = role);
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  role,
                  style: AppTheme.uzbekBody.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                if (_showResult && isCorrect) ...[
                  const SizedBox(width: 6),
                  const Icon(Icons.check_circle,
                      color: AppColors.emerald, size: 18),
                ],
                if (_showResult && isSelected && !isCorrect) ...[
                  const SizedBox(width: 6),
                  const Icon(Icons.cancel,
                      color: AppColors.deepRed, size: 18),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeedback(_TokenInfo token) {
    final correct = _selected == token.role;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (correct ? AppColors.emerald : AppColors.gold).withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: (correct ? AppColors.emerald : AppColors.gold)
              .withOpacity(0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            correct ? Icons.check_circle : Icons.lightbulb,
            color: correct ? AppColors.emerald : AppColors.gold,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  correct ? 'To\'g\'ri! +15 XP' : 'To\'g\'ri javob: ${token.role}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: correct ? AppColors.emerald : AppColors.softBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(token.explanation, style: AppTheme.uzbekBody),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildAction(_AyahTask task) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _showResult
            ? _next
            : (_selected == null
                ? null
                : () {
                    final correct =
                        _selected == task.tokens[_tokenIndex].role;
                    if (correct) {
                      Haptics.success();
                      _score += 15;
                      context.read<ProgressService>().addXp(15);
                      _confetti.play();
                    } else {
                      Haptics.error();
                      context.read<ProgressService>().loseHeart();
                    }
                    setState(() => _showResult = true);
                  }),
        child: Text(_showResult
            ? (_tokenIndex < task.tokens.length - 1 ||
                    _taskIndex < _tasks.length - 1
                ? 'Keyingisi →'
                : 'Yakunlash 🎉')
            : 'Tekshirish'),
      ),
    );
  }

  void _next() {
    Haptics.tap();
    final task = _tasks[_taskIndex];
    setState(() {
      _selected = null;
      _showResult = false;
      if (_tokenIndex < task.tokens.length - 1) {
        _tokenIndex++;
      } else {
        _tokenIndex = 0;
        _taskIndex++;
      }
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
                const Mascot(mood: MascotMood.celebrating, size: 120),
                const SizedBox(height: 24),
                Text('Subhanalloh! 🌟',
                    style: AppTheme.uzbekTitle.copyWith(fontSize: 32))
                    .animate()
                    .fadeIn(duration: 600.ms),
                const SizedBox(height: 8),
                Text(
                  'Qur\'on tahlilini yakunladingiz',
                  style: AppTheme.uzbekBody.copyWith(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                GoldFrame(
                  child: Column(
                    children: [
                      Text('+$_score XP',
                          style: GoogleFonts.amiri(
                            fontSize: 42,
                            color: AppColors.emerald,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        '${_tasks.fold(0, (a, t) => a + t.tokens.length)} ta tahlildan $_score ball',
                        style: AppTheme.uzbekBody,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _taskIndex = 0;
                    _tokenIndex = 0;
                    _score = 0;
                    _selected = null;
                    _showResult = false;
                  }),
                  child: const Text('Yana mashq'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.maybePop(context),
                  child: const Text('O\'yinlarga qaytish'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
