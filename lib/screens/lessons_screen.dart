import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/lessons_data.dart';
import '../models/lesson.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/geometric_pattern.dart';
import 'lesson_detail_screen.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text('📚', style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Text('Darslar', style: AppTheme.uzbekTitle),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.ivory,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.gold.withOpacity(0.4)),
                ),
                child: TabBar(
                  controller: _tab,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    gradient: AppColors.emeraldGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.ivory,
                  unselectedLabelColor: AppColors.softBrown,
                  labelStyle: GoogleFonts.merriweather(
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: const [
                    Tab(text: 'Barchasi'),
                    Tab(text: 'Nahv'),
                    Tab(text: 'Sarf'),
                    Tab(text: 'Tarkib'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tab,
                  children: [
                    _LessonList(category: null),
                    _LessonList(category: LessonCategory.nahv),
                    _LessonList(category: LessonCategory.sarf),
                    _LessonList(category: LessonCategory.tarkib),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LessonList extends StatelessWidget {
  final LessonCategory? category;
  const _LessonList({this.category});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>().progress;
    final lessons = category == null
        ? LessonsData.allLessons
        : LessonsData.getByCategory(category!);

    if (lessons.isEmpty) {
      return Center(
        child: Text(
          'Tez orada qo\'shiladi',
          style: AppTheme.uzbekBody,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lessons.length,
      itemBuilder: (context, i) {
        final lesson = lessons[i];
        final completed = progress.completedLessons.contains(lesson.id);
        final score = progress.lessonScores[lesson.id];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _LessonCard(
            lesson: lesson,
            completed: completed,
            score: score,
            index: i + 1,
          ),
        )
            .animate(delay: (i * 80).ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: 0.1, end: 0);
      },
    );
  }
}

class _LessonCard extends StatelessWidget {
  final Lesson lesson;
  final bool completed;
  final int? score;
  final int index;

  const _LessonCard({
    required this.lesson,
    required this.completed,
    required this.score,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor = _categoryColor(lesson.category);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LessonDetailScreen(lesson: lesson),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.ivory,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: completed
                  ? AppColors.emerald
                  : AppColors.gold.withOpacity(0.4),
              width: completed ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: categoryColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [categoryColor, categoryColor.withOpacity(0.7)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: completed
                      ? const Icon(Icons.check, color: Colors.white, size: 28)
                      : Text(
                          '$index',
                          style: GoogleFonts.amiri(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.arabicTitle,
                      style: GoogleFonts.amiri(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.emerald,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      lesson.title,
                      style: AppTheme.uzbekBody.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _categoryName(lesson.category),
                            style: TextStyle(
                              color: categoryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (score != null)
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 14, color: AppColors.gold),
                              Text(
                                ' $score',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.softBrown,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.gold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _categoryColor(LessonCategory c) {
    switch (c) {
      case LessonCategory.nahv:
        return AppColors.emerald;
      case LessonCategory.sarf:
        return AppColors.softBrown;
      case LessonCategory.tarkib:
        return AppColors.deepRed;
      case LessonCategory.vocabulary:
        return AppColors.forestGreen;
    }
  }

  String _categoryName(LessonCategory c) {
    switch (c) {
      case LessonCategory.nahv:
        return 'Nahv';
      case LessonCategory.sarf:
        return 'Sarf';
      case LessonCategory.tarkib:
        return 'Tarkib';
      case LessonCategory.vocabulary:
        return 'Lug\'at';
    }
  }
}
