import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';
import '../models/lesson.dart';
import '../services/audio_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/geometric_pattern.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;
  const LessonDetailScreen({super.key, required this.lesson});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  final _audio = AudioService();
  int _phase = 0; // 0 = theory, 1 = quiz, 2 = done

  // quiz state
  int _quizIndex = 0;
  int _correctCount = 0;
  int? _selected;
  bool _showResult = false;

  late ConfettiController _confetti;

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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  _buildAppBar(),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: _buildPhase(),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  numberOfParticles: 30,
                  colors: const [
                    AppColors.gold,
                    AppColors.emerald,
                    AppColors.deepRed,
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

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: AppColors.emerald),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.lesson.arabicTitle,
                  style: GoogleFonts.amiri(
                    color: AppColors.emerald,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  widget.lesson.title,
                  style: AppTheme.uzbekBody.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhase() {
    if (_phase == 0) return _theoryView();
    if (_phase == 1) return _quizView();
    return _doneView();
  }

  Widget _theoryView() {
    return ListView(
      key: const ValueKey('theory'),
      padding: const EdgeInsets.all(20),
      children: [
        GoldFrame(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.school, color: AppColors.gold, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Nazariya',
                    style: AppTheme.uzbekTitle.copyWith(fontSize: 18),
                  ),
                ],
              ),
              const OrnamentDivider(),
              _MarkdownLite(text: widget.lesson.theory),
              const SizedBox(height: 8),
              Text(
                'Manba: ${widget.lesson.source}',
                style: GoogleFonts.merriweather(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: AppColors.softBrown,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 400.ms),
        const SizedBox(height: 20),
        if (widget.lesson.examples.isNotEmpty) ...[
          Text('Misollar 💡',
              style: AppTheme.uzbekTitle.copyWith(fontSize: 18)),
          const SizedBox(height: 12),
          ...widget.lesson.examples.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ExampleCard(example: e.value, audio: _audio),
            )
                .animate(delay: (e.key * 100).ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1);
          }),
        ],
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => setState(() => _phase = 1),
          icon: const Icon(Icons.play_arrow),
          label: const Text('Imtihonni boshlash'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _quizView() {
    final quiz = widget.lesson.quizzes[_quizIndex];
    final total = widget.lesson.quizzes.length;

    return ListView(
      key: ValueKey('quiz_$_quizIndex'),
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Savol ${_quizIndex + 1} / $total',
                style: AppTheme.uzbekBody.copyWith(fontWeight: FontWeight.bold)),
            Text('Bal: $_correctCount',
                style: TextStyle(
                    color: AppColors.emerald, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: (_quizIndex + 1) / total,
            minHeight: 8,
            backgroundColor: AppColors.sage.withOpacity(0.2),
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.emerald),
          ),
        ),
        const SizedBox(height: 24),
        if (quiz.arabicSentence != null)
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: AppColors.emeraldGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  quiz.arabicSentence!,
                  style: GoogleFonts.amiri(
                    fontSize: 26,
                    color: AppColors.goldLight,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: AppColors.goldLight),
                  onPressed: () => _audio.speak(quiz.arabicSentence!),
                ),
              ],
            ),
          ),
        Text(quiz.question,
            style: AppTheme.uzbekTitle.copyWith(fontSize: 18)),
        const SizedBox(height: 16),
        ...quiz.options.asMap().entries.map((e) {
          final idx = e.key;
          final opt = e.value;
          final isSelected = _selected == idx;
          final isCorrect = idx == quiz.correctIndex;
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
            borderColor = AppColors.emerald;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: _showResult ? null : () => setState(() => _selected = idx),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor, width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: borderColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor),
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode(65 + idx),
                          style: TextStyle(
                            color: borderColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        opt,
                        style: GoogleFonts.amiri(
                          fontSize: 18,
                          color: AppColors.charcoal,
                        ),
                      ),
                    ),
                    if (_showResult && isCorrect)
                      const Icon(Icons.check_circle,
                          color: AppColors.emerald, size: 24),
                    if (_showResult && isSelected && !isCorrect)
                      const Icon(Icons.cancel,
                          color: AppColors.deepRed, size: 24),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
        if (_showResult) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.goldLight.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.gold.withOpacity(0.4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb, color: AppColors.gold),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(quiz.explanation, style: AppTheme.uzbekBody),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _next,
            child: Text(_quizIndex < total - 1 ? 'Keyingisi →' : 'Yakunlash 🎉'),
          ),
        ] else
          ElevatedButton(
            onPressed: _selected == null ? null : _check,
            child: const Text('Tekshirish'),
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _check() {
    final correct =
        _selected == widget.lesson.quizzes[_quizIndex].correctIndex;
    if (correct) {
      _correctCount++;
    } else {
      context.read<ProgressService>().loseHeart();
    }
    setState(() => _showResult = true);
  }

  void _next() {
    if (_quizIndex < widget.lesson.quizzes.length - 1) {
      setState(() {
        _quizIndex++;
        _selected = null;
        _showResult = false;
      });
    } else {
      final score = _correctCount * 10;
      context
          .read<ProgressService>()
          .completeLesson(widget.lesson.id, score);
      _confetti.play();
      setState(() => _phase = 2);
    }
  }

  Widget _doneView() {
    final total = widget.lesson.quizzes.length;
    final percent = total == 0 ? 0 : (_correctCount * 100 ~/ total);
    final passed = percent == 100;

    return Padding(
      key: const ValueKey('done'),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(passed ? '🎉' : '💪',
              style: const TextStyle(fontSize: 80))
              .animate()
              .scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 16),
          Text(
            passed ? 'Tabriklayman!' : 'Yaxshi harakat!',
            style: AppTheme.uzbekTitle.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 8),
          Text(
            '$_correctCount / $total to\'g\'ri',
            style: AppTheme.uzbekBody.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 24),
          GoldFrame(
            child: Column(
              children: [
                Text('+${_correctCount * 10} XP',
                    style: GoogleFonts.amiri(
                      fontSize: 36,
                      color: AppColors.emerald,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 4),
                Text('$percent% to\'g\'ri',
                    style: AppTheme.uzbekBody),
              ],
            ),
          ),
          const SizedBox(height: 32),
          if (!passed)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.deepRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info, color: AppColors.deepRed),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '100% Mastery! Keyingi darsga o\'tish uchun barcha savollarni to\'g\'ri javob bering.',
                      style: AppTheme.uzbekBody.copyWith(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          if (!passed)
            ElevatedButton(
              onPressed: () => setState(() {
                _phase = 1;
                _quizIndex = 0;
                _correctCount = 0;
                _selected = null;
                _showResult = false;
              }),
              child: const Text('Qaytadan urinish'),
            ),
          if (passed)
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Darslarga qaytish'),
            ),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  final Example example;
  final AudioService audio;
  const _ExampleCard({required this.example, required this.audio});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  example.arabic,
                  style: AppTheme.arabicLarge,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.volume_up, color: AppColors.emerald),
                onPressed: () => audio.speak(example.arabic),
              ),
            ],
          ),
          Text(
            example.transliteration,
            style: GoogleFonts.merriweather(
              fontStyle: FontStyle.italic,
              color: AppColors.softBrown,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(example.translation, style: AppTheme.uzbekBody),
          if (example.grammarNote != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.emerald.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.menu_book, size: 14, color: AppColors.emerald),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      example.grammarNote!,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.emerald,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MarkdownLite extends StatelessWidget {
  final String text;
  const _MarkdownLite({required this.text});

  @override
  Widget build(BuildContext context) {
    final lines = text.trim().split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }
      widgets.add(_buildLine(line));
      widgets.add(const SizedBox(height: 4));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildLine(String line) {
    final spans = <InlineSpan>[];
    final regex = RegExp(r'\*\*([^*]+)\*\*|([^*]+)');
    for (final match in regex.allMatches(line)) {
      if (match.group(1) != null) {
        spans.add(TextSpan(
          text: match.group(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      } else if (match.group(2) != null) {
        spans.add(TextSpan(text: match.group(2)));
      }
    }
    return RichText(
      text: TextSpan(
        children: spans,
        style: GoogleFonts.merriweather(
          fontSize: 15,
          color: AppColors.charcoal,
          height: 1.6,
        ),
      ),
    );
  }
}
