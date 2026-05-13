import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/haptic_service.dart';
import '../../services/progress_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/geometric_pattern.dart';

class _SearchWord {
  final String arabic;
  final String uzbek;
  const _SearchWord(this.arabic, this.uzbek);
}

class WordSearchGame extends StatefulWidget {
  const WordSearchGame({super.key});

  @override
  State<WordSearchGame> createState() => _WordSearchGameState();
}

class _WordSearchGameState extends State<WordSearchGame> {
  static const int gridSize = 8;
  // Simple Arabic letters (without complex diacritics) for grid
  static const _arabicLetters = [
    'ا','ب','ت','ث','ج','ح','خ','د','ذ','ر','ز','س','ش','ص','ض','ط','ع','ف','ق','ك','ل','م','ن','ه','و','ي'
  ];

  static const _wordPool = [
    _SearchWord('كتاب', 'kitob'),
    _SearchWord('بيت', 'uy'),
    _SearchWord('قلم', 'qalam'),
    _SearchWord('باب', 'eshik'),
    _SearchWord('ماء', 'suv'),
    _SearchWord('شمس', 'quyosh'),
    _SearchWord('قمر', 'oy'),
    _SearchWord('يد', 'qo\'l'),
    _SearchWord('فم', 'og\'iz'),
    _SearchWord('ام', 'ona'),
  ];

  late List<List<String>> _grid;
  late List<_SearchWord> _targetWords;
  final Set<String> _found = {};
  final List<_Cell> _selected = [];

  @override
  void initState() {
    super.initState();
    _generateGrid();
  }

  void _generateGrid() {
    final rng = Random();
    _grid = List.generate(
      gridSize,
      (_) => List.generate(gridSize, (_) => _arabicLetters[rng.nextInt(_arabicLetters.length)]),
    );

    _targetWords = (List.of(_wordPool)..shuffle()).take(4).toList();

    // Try to place each word horizontally (right-to-left for Arabic)
    for (final w in _targetWords) {
      final letters = w.arabic.split('');
      bool placed = false;
      for (int attempt = 0; attempt < 50 && !placed; attempt++) {
        final row = rng.nextInt(gridSize);
        final maxStartCol = gridSize - letters.length;
        if (maxStartCol < 0) continue;
        final startCol = rng.nextInt(maxStartCol + 1);
        // Place left-to-right in the grid (we'll display RTL)
        for (int i = 0; i < letters.length; i++) {
          _grid[row][startCol + i] = letters[i];
        }
        placed = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final allFound = _found.length == _targetWords.length;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 8),
              if (allFound)
                Expanded(child: _winView())
              else ...[
                _buildWordList(),
                Expanded(child: _buildGrid()),
                _buildSelected(),
              ],
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
            onPressed: () {
              Haptics.tap();
              Navigator.maybePop(context);
            },
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text('So\'z topish 🔍',
                      style: AppTheme.uzbekTitle.copyWith(fontSize: 18)),
                  Text('${_found.length}/${_targetWords.length} topildi',
                      style: TextStyle(
                          color: AppColors.emerald,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.gold),
            onPressed: () {
              Haptics.tap();
              setState(() {
                _found.clear();
                _selected.clear();
                _generateGrid();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWordList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withOpacity(0.4)),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: _targetWords.map((w) {
          final found = _found.contains(w.arabic);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: found
                  ? AppColors.emerald.withOpacity(0.15)
                  : AppColors.gold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: found ? AppColors.emerald : AppColors.gold,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(w.arabic,
                    style: GoogleFonts.amiri(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: found ? AppColors.emerald : AppColors.charcoal,
                      decoration:
                          found ? TextDecoration.lineThrough : null,
                    ),
                    textDirection: TextDirection.rtl),
                const SizedBox(width: 6),
                Text('(${w.uzbek})',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.softBrown,
                    )),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.ivory,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.gold, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withOpacity(0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: gridSize * gridSize,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemBuilder: (_, i) {
                final row = i ~/ gridSize;
                final col = i % gridSize;
                final selected =
                    _selected.any((c) => c.row == row && c.col == col);
                return GestureDetector(
                  onTap: () => _tapCell(row, col),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      gradient: selected ? AppColors.goldGradient : null,
                      color: selected ? null : AppColors.sage.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: selected
                            ? AppColors.gold
                            : AppColors.emerald.withOpacity(0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _grid[row][col],
                        style: GoogleFonts.amiri(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: selected
                              ? AppColors.softBrown
                              : AppColors.emerald,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelected() {
    if (_selected.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          'Harflarni bosib so\'z yasang',
          style: AppTheme.uzbekBody.copyWith(fontSize: 12),
        ),
      );
    }
    // Build word from selected cells in RTL order (rightmost first)
    final sorted = List.of(_selected)
      ..sort((a, b) => b.col.compareTo(a.col));
    final word = sorted.map((c) => _grid[c.row][c.col]).join();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: AppColors.emeraldGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                word,
                style: GoogleFonts.amiri(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goldLight,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.check, color: AppColors.goldLight),
            onPressed: () => _checkWord(word),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.goldLight),
            onPressed: () {
              Haptics.tap();
              setState(_selected.clear);
            },
          ),
        ],
      ),
    );
  }

  void _tapCell(int row, int col) {
    Haptics.click();
    setState(() {
      final existing =
          _selected.indexWhere((c) => c.row == row && c.col == col);
      if (existing >= 0) {
        _selected.removeAt(existing);
      } else {
        _selected.add(_Cell(row, col));
      }
    });
  }

  void _checkWord(String word) {
    final found = _targetWords.firstWhere(
      (w) => w.arabic == word,
      orElse: () => const _SearchWord('', ''),
    );
    if (found.arabic.isNotEmpty && !_found.contains(found.arabic)) {
      Haptics.success();
      setState(() {
        _found.add(found.arabic);
        _selected.clear();
      });
      context.read<ProgressService>().addXp(15);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Topildi! +15 XP — ${found.uzbek}'),
          backgroundColor: AppColors.emerald,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      Haptics.error();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bu so\'z ro\'yxatda yo\'q yoki allaqachon topilgan'),
          backgroundColor: AppColors.deepRed,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
      setState(_selected.clear);
    }
  }

  Widget _winView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🎉', style: const TextStyle(fontSize: 96))
              .animate()
              .scale(curve: Curves.elasticOut, duration: 700.ms),
          const SizedBox(height: 16),
          Text('Barchasini topdingiz!',
              style: AppTheme.uzbekTitle.copyWith(fontSize: 28),
              textAlign: TextAlign.center),
          const SizedBox(height: 24),
          GoldFrame(
            child: Text('+${_targetWords.length * 15} XP',
                style: GoogleFonts.amiri(
                  fontSize: 36,
                  color: AppColors.emerald,
                  fontWeight: FontWeight.bold,
                )),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => setState(() {
              _found.clear();
              _selected.clear();
              _generateGrid();
            }),
            child: const Text('Yangi puzzle'),
          ),
        ],
      ),
    );
  }
}

class _Cell {
  final int row;
  final int col;
  const _Cell(this.row, this.col);
}
