import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../widgets/geometric_pattern.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const _doneKey = 'onboarding_done';

  static Future<bool> isDone() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_doneKey) ?? false;
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _page = PageController();
  int _index = 0;
  String? _level;
  String? _goal;

  final _slides = const [
    _Slide(
      emoji: '🕌',
      title: 'Xush kelibsiz!',
      subtitle: 'Arab tilini 0 dan mukammallikkacha\no\'rganishingiz uchun yaratilgan',
    ),
    _Slide(
      emoji: '📚',
      title: '4 ta nufuzli manba',
      subtitle: 'M. Hasanov, S. Bekpo\'lat, D. Bodariy,\nTIU darsliklari asosida',
    ),
    _Slide(
      emoji: '🎯',
      title: '100% Mastery',
      subtitle: 'MIT metodikasi — har bir darsni\nmukammal o\'rganmaguningizcha keyingiga o\'tilmaydi',
    ),
    _Slide(
      emoji: '🎮',
      title: 'Interaktiv mashqlar',
      subtitle: 'Kartochkalar, o\'yinlar, audio talaffuz\nva I\'rob tahlili — hammasi bir joyda',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GeometricPatternBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _page,
                  onPageChanged: (i) => setState(() => _index = i),
                  children: [
                    ..._slides.map((s) => _slideView(s)),
                    _levelView(),
                    _goalView(),
                  ],
                ),
              ),
              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _slideView(_Slide slide) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(slide.emoji, style: const TextStyle(fontSize: 120))
              .animate()
              .scale(curve: Curves.elasticOut, duration: 700.ms),
          const SizedBox(height: 32),
          Text(
            slide.title,
            style: AppTheme.uzbekTitle.copyWith(fontSize: 32),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 12),
          Text(
            slide.subtitle,
            style: AppTheme.uzbekBody.copyWith(fontSize: 16, height: 1.6),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }

  Widget _levelView() {
    final levels = [
      _Option('🟢', 'Mutlaq boshlovchi', 'Arab alifbosini hali bilmayman'),
      _Option('🟡', 'Boshlang\'ich', 'Harflarni o\'qiyman, lekin grammatika yo\'q'),
      _Option('🟠', 'O\'rta', 'Asosiy qoidalarni bilaman'),
      _Option('🔴', 'Yuqori', 'I\'rob va Sarf tahlili qila olaman'),
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Bilim darajangiz?',
            style: AppTheme.uzbekTitle.copyWith(fontSize: 26),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ...levels.map((l) {
            final selected = _level == l.title;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => setState(() => _level = l.title),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.ivory,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selected
                          ? AppColors.emerald
                          : AppColors.gold.withOpacity(0.4),
                      width: selected ? 2.5 : 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(l.emoji, style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l.title,
                                style: AppTheme.uzbekBody.copyWith(
                                    fontWeight: FontWeight.bold)),
                            Text(l.subtitle,
                                style: AppTheme.uzbekBody
                                    .copyWith(fontSize: 12)),
                          ],
                        ),
                      ),
                      if (selected)
                        const Icon(Icons.check_circle,
                            color: AppColors.emerald),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _goalView() {
    final goals = [
      _Option('📖', 'Qur\'on matnini tushunish', ''),
      _Option('📚', 'Klassik adabiyot o\'qish', ''),
      _Option('🎓', 'Imtihonga tayyorgarlik', ''),
      _Option('🗣️', 'Og\'zaki muloqot', ''),
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Maqsadingiz nima?',
            style: AppTheme.uzbekTitle.copyWith(fontSize: 26),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text('Bu sizga eng mos darslar tanlashda yordam beradi',
              style: AppTheme.uzbekBody.copyWith(fontSize: 13),
              textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ...goals.map((g) {
            final selected = _goal == g.title;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => setState(() => _goal = g.title),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: selected ? AppColors.emeraldGradient : null,
                    color: selected ? null : AppColors.ivory,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selected
                          ? AppColors.emerald
                          : AppColors.gold.withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(g.emoji, style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          g.title,
                          style: AppTheme.uzbekBody.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: selected
                                ? AppColors.goldLight
                                : AppColors.charcoal,
                          ),
                        ),
                      ),
                      if (selected)
                        const Icon(Icons.check_circle,
                            color: AppColors.goldLight),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    final totalPages = _slides.length + 2;
    final isLast = _index == totalPages - 1;
    final isLevelPage = _index == _slides.length;
    final isGoalPage = _index == _slides.length + 1;
    final canProceed =
        (!isLevelPage || _level != null) && (!isGoalPage || _goal != null);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalPages, (i) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == _index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == _index
                      ? AppColors.emerald
                      : AppColors.sage.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              if (_index > 0)
                Expanded(
                  child: TextButton(
                    onPressed: () => _page.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    ),
                    child: const Text('Ortga'),
                  ),
                ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: canProceed
                      ? () {
                          if (isLast) {
                            _finish();
                          } else {
                            _page.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        }
                      : null,
                  child: Text(isLast ? 'Boshlash 🚀' : 'Davom etish →'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _finish() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(OnboardingScreen._doneKey, true);
    if (_level != null) await p.setString('user_level', _level!);
    if (_goal != null) await p.setString('user_goal', _goal!);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, a, __) => const HomeScreen(),
        transitionsBuilder: (_, a, __, child) =>
            FadeTransition(opacity: a, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}

class _Slide {
  final String emoji;
  final String title;
  final String subtitle;
  const _Slide(
      {required this.emoji, required this.title, required this.subtitle});
}

class _Option {
  final String emoji;
  final String title;
  final String subtitle;
  const _Option(this.emoji, this.title, this.subtitle);
}
