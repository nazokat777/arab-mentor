import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../services/progress_service.dart';
import '../widgets/geometric_pattern.dart';
import '../widgets/stat_widgets.dart';
import 'lessons_screen.dart';
import 'flashcard_screen.dart';
import 'games_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  final _tabs = const [
    _HomeTab(),
    LessonsScreen(),
    FlashcardScreen(),
    GamesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentTab],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.ivory,
          border: Border(
            top: BorderSide(color: AppColors.gold.withOpacity(0.4), width: 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.emerald.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: (i) => setState(() => _currentTab = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.emerald,
          unselectedItemColor: AppColors.softBrown.withOpacity(0.5),
          selectedLabelStyle: GoogleFonts.merriweather(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: GoogleFonts.merriweather(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Bosh'),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                activeIcon: Icon(Icons.menu_book),
                label: 'Darslar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.style_outlined),
                activeIcon: Icon(Icons.style),
                label: 'Kartochka'),
            BottomNavigationBarItem(
                icon: Icon(Icons.videogame_asset_outlined),
                activeIcon: Icon(Icons.videogame_asset),
                label: 'O\'yinlar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>().progress;

    return GeometricPatternBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assalomu alaykum 👋',
                        style: GoogleFonts.merriweather(
                          color: AppColors.softBrown,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Bugun ham o\'rganamiz!',
                        style: AppTheme.uzbekTitle,
                      ),
                    ],
                  ),
                ),
                StreakBadge(streak: progress.streak),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HeartsBadge(hearts: progress.hearts),
                const SizedBox(width: 8),
                GemsBadge(gems: progress.gems),
              ],
            ),
            const SizedBox(height: 20),
            GoldFrame(
              child: LevelProgressBar(
                level: progress.level,
                progress: progress.progressToNextLevel,
                xp: progress.xp,
                xpForNext: progress.xpForNextLevel,
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
            const SizedBox(height: 24),
            Text(
              'Bugungi Oyat 📖',
              style: AppTheme.uzbekTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),
            _AyahCard(),
            const SizedBox(height: 24),
            Text(
              'Tezkor boshlash 🚀',
              style: AppTheme.uzbekTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _QuickCard(
                  icon: '📚',
                  title: 'Darslar',
                  subtitle: 'Nahv & Sarf',
                  gradient: AppColors.emeraldGradient,
                  onTap: () => _go(context, const LessonsScreen()),
                ),
                _QuickCard(
                  icon: '🎴',
                  title: 'Kartochkalar',
                  subtitle: 'Lug\'at',
                  gradient: AppColors.goldGradient,
                  onTap: () => _go(context, const FlashcardScreen()),
                ),
                _QuickCard(
                  icon: '🎮',
                  title: 'O\'yinlar',
                  subtitle: 'Mashqlar',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B2331), Color(0xFFB85450)],
                  ),
                  onTap: () => _go(context, const GamesScreen()),
                ),
                _QuickCard(
                  icon: '⭐',
                  title: 'Profil',
                  subtitle: 'Statistika',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6B4423), Color(0xFFA67B5B)],
                  ),
                  onTap: () => _go(context, const ProfileScreen()),
                ),
              ],
            ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _go(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }
}

class _AyahCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'وَقُل رَّبِّ زِدْنِي عِلْمًا',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: GoogleFonts.amiri(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.goldLight,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '"Rabbim, ilmimni ziyoda qilgin"',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontStyle: FontStyle.italic,
              color: AppColors.cream,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Toha surasi: 114',
            style: GoogleFonts.merriweather(
              color: AppColors.goldLight.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const _QuickCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradient.colors.first.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(icon, style: const TextStyle(fontSize: 36)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.merriweather(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.merriweather(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
