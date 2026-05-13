import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/audio_service.dart';
import '../../services/progress_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/geometric_pattern.dart';

class _Puzzle {
  final List<String> words;
  final String translation;
  const _Puzzle(this.words, this.translation);
}

class SentenceBuilderGame extends StatefulWidget {
  const SentenceBuilderGame({super.key});

  @override
  State<SentenceBuilderGame> createState() => _SentenceBuilderGameState();
}

class _SentenceBuilderGameState extends State<SentenceBuilderGame> {
  final _audio = AudioService();

  static const _puzzles = [
    _Puzzle(['الكِتَابُ', 'جَدِيدٌ'], 'Kitob yangi'),
    _Puzzle(['الطَّالِبُ', 'مُجْتَهِدٌ'], 'Talaba tirishqoq'),
    _Puzzle(['كَتَبَ', 'الطَّالِبُ', 'الدَّرْسَ'], 'Talaba darsni yozdi'),
    _Puzzle(['قَرَأَ', 'المُعَلِّمُ', 'الكِتَابَ'],
        'O\'qituvchi kitobni o\'qidi'),
    _Puzzle(['البَيْتُ', 'كَبِيرٌ'], 'Uy katta'),
    _Puzzle(['ذَهَبَ', 'الطَّالِبُ', 'إِلَى', 'المَدْرَسَةِ'],
        'Talaba maktabga bordi'),
  ];

  int _index = 0;
  List<String> _bank = [];
  List<String> _answer = [];
  bool? _correct;

  @override
  void initState() {
    super.initState();
    _loadPuzzle();
  }

  void _loadPuzzle() {
    _bank = List.of(_puzzles[_index].words)..shuffle();
    _answer = [];
    _correct = null;
  }

  @override
  Widget build(BuildContext context) {
    final puzzle = _puzzles[_index];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _hintCard(puzzle),
              const SizedBox(height: 24),
              _answerRow(),
              const Spacer(),
              _bankRow(),
              const SizedBox(height: 16),
              if (_correct != null) _feedback(puzzle),
              const SizedBox(height: 16),
              _checkButton(puzzle),
              const SizedBox(height: 20),
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
                  Text('Gap yasash 🧩',
                      style: AppTheme.uzbekTitle.copyWith(fontSize: 18)),
                  Text('${_index + 1}/${_puzzles.length}',
                      style: AppTheme.uzbekBody),
                ],
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _hintCard(_Puzzle puzzle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.emeraldGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.translate, color: AppColors.goldLight),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              puzzle.translation,
              style: GoogleFonts.merriweather(
                color: AppColors.goldLight,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _answerRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(12),
      constraints: const BoxConstraints(minHeight: 80),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _correct == true
              ? AppColors.emerald
              : _correct == false
                  ? AppColors.deepRed
                  : AppColors.gold.withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _answer
              .asMap()
              .entries
              .map((e) => _wordChip(e.value, inAnswer: true, index: e.key))
              .toList(),
        ),
      ),
    );
  }

  Widget _bankRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: _bank
            .asMap()
            .entries
            .map((e) => _wordChip(e.value, inAnswer: false, index: e.key))
            .toList(),
      ),
    );
  }

  Widget _wordChip(String word, {required bool inAnswer, required int index}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _correct != null
            ? null
            : () {
                setState(() {
                  if (inAnswer) {
                    _answer.removeAt(index);
                    _bank.add(word);
                  } else {
                    _bank.removeAt(index);
                    _answer.add(word);
                  }
                });
              },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient:
                inAnswer ? AppColors.emeraldGradient : AppColors.goldGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: (inAnswer ? AppColors.emerald : AppColors.gold)
                    .withOpacity(0.25),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            word,
            style: GoogleFonts.amiri(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: inAnswer ? AppColors.goldLight : AppColors.softBrown,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }

  Widget _feedback(_Puzzle puzzle) {
    final correct = _correct == true;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (correct ? AppColors.emerald : AppColors.deepRed)
            .withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(correct ? Icons.check_circle : Icons.cancel,
              color: correct ? AppColors.emerald : AppColors.deepRed),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              correct
                  ? 'Zo\'r! +10 XP'
                  : 'To\'g\'ri javob: ${puzzle.words.join(" ")}',
              style: TextStyle(
                color: correct ? AppColors.emerald : AppColors.deepRed,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.volume_up),
            color: AppColors.emerald,
            onPressed: () => _audio.speak(puzzle.words.join(' ')),
          ),
        ],
      ),
    );
  }

  Widget _checkButton(_Puzzle puzzle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _correct != null
              ? _next
              : (_answer.length == puzzle.words.length ? _check : null),
          child: Text(_correct == null
              ? 'Tekshirish'
              : _index < _puzzles.length - 1
                  ? 'Keyingisi →'
                  : 'Yakunlash 🎉'),
        ),
      ),
    );
  }

  void _check() {
    final puzzle = _puzzles[_index];
    final correct = _answer.join(' ') == puzzle.words.join(' ');
    setState(() => _correct = correct);
    if (correct) {
      context.read<ProgressService>().addXp(10);
    } else {
      context.read<ProgressService>().loseHeart();
    }
  }

  void _next() {
    if (_index < _puzzles.length - 1) {
      setState(() {
        _index++;
        _loadPuzzle();
      });
    } else {
      _showFinish();
    }
  }

  void _showFinish() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.ivory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text('🎉 Yakunlandi!',
            style: AppTheme.uzbekTitle, textAlign: TextAlign.center),
        content: Text(
          'Barcha gaplarni yasadingiz. Yana o\'ynaysizmi?',
          style: AppTheme.uzbekBody,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Chiqish'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _index = 0;
                _loadPuzzle();
              });
            },
            child: const Text('Yana o\'ynash'),
          ),
        ],
      ),
    );
  }
}
