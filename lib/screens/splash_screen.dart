import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/geometric_pattern.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, a, __) => const HomeScreen(),
          transitionsBuilder: (_, a, __, child) =>
              FadeTransition(opacity: a, child: child),
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeometricPatternBackground(
        opacity: 0.08,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: AppColors.emeraldGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.emerald.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Text(
                  'ع',
                  style: GoogleFonts.amiri(
                    fontSize: 72,
                    color: AppColors.goldLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  .animate()
                  .scale(duration: 800.ms, curve: Curves.easeOutBack)
                  .then(delay: 200.ms)
                  .shimmer(duration: 1500.ms, color: AppColors.goldLight),
              const SizedBox(height: 32),
              Text(
                'Arab Mentor',
                style: GoogleFonts.amiri(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: AppColors.emerald,
                ),
              ).animate().fadeIn(delay: 500.ms, duration: 600.ms).slideY(
                    begin: 0.3,
                    end: 0,
                    delay: 500.ms,
                    duration: 600.ms,
                  ),
              const SizedBox(height: 8),
              Text(
                'مُرْشِدُ اللُّغَةِ العَرَبِيَّةِ',
                style: GoogleFonts.amiri(
                  fontSize: 20,
                  color: AppColors.softBrown,
                ),
                textDirection: TextDirection.rtl,
              ).animate().fadeIn(delay: 900.ms, duration: 600.ms),
              const SizedBox(height: 48),
              const OrnamentDivider(),
              const SizedBox(height: 16),
              Text(
                'Bismillah — boshlaymiz',
                style: GoogleFonts.merriweather(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: AppColors.softBrown,
                ),
              ).animate().fadeIn(delay: 1400.ms, duration: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}
