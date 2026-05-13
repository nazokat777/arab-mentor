import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/audio_service.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/geometric_pattern.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _audioSpeed = 0.4;
  bool _soundEnabled = true;
  bool _dailyReminder = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      _audioSpeed = p.getDouble('audio_speed') ?? 0.4;
      _soundEnabled = p.getBool('sound_enabled') ?? true;
      _dailyReminder = p.getBool('daily_reminder') ?? true;
    });
  }

  Future<void> _savePref(String key, dynamic value) async {
    final p = await SharedPreferences.getInstance();
    if (value is double) await p.setDouble(key, value);
    if (value is bool) await p.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
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
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.emerald),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const SizedBox(width: 8),
                  Text('Sozlamalar ⚙️',
                      style: AppTheme.uzbekTitle),
                ],
              ),
              const SizedBox(height: 16),
              _section('Audio'),
              _SettingCard(
                icon: Icons.volume_up,
                title: 'Tovush yoqilgan',
                subtitle: 'Mashqlar va talaffuzlar uchun',
                trailing: Switch(
                  value: _soundEnabled,
                  activeColor: AppColors.emerald,
                  onChanged: (v) {
                    setState(() => _soundEnabled = v);
                    _savePref('sound_enabled', v);
                  },
                ),
              ),
              const SizedBox(height: 8),
              _SettingCard(
                icon: Icons.speed,
                title: 'Audio tezligi',
                subtitle: 'TTS o\'qish tezligi',
                child: Column(
                  children: [
                    Slider(
                      value: _audioSpeed,
                      min: 0.2,
                      max: 0.8,
                      divisions: 6,
                      activeColor: AppColors.emerald,
                      label: _speedLabel(_audioSpeed),
                      onChanged: (v) {
                        setState(() => _audioSpeed = v);
                        _savePref('audio_speed', v);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sekin', style: AppTheme.uzbekBody.copyWith(fontSize: 12)),
                        Text(_speedLabel(_audioSpeed),
                            style: AppTheme.uzbekBody.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.emerald)),
                        Text('Tez', style: AppTheme.uzbekBody.copyWith(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () =>
                          AudioService().speak('بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ'),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Sinash'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _section('Bildirishnomalar'),
              _SettingCard(
                icon: Icons.notifications,
                title: 'Kunlik eslatma',
                subtitle: 'Streak\'ni saqlash uchun har kuni',
                trailing: Switch(
                  value: _dailyReminder,
                  activeColor: AppColors.emerald,
                  onChanged: (v) {
                    setState(() => _dailyReminder = v);
                    _savePref('daily_reminder', v);
                  },
                ),
              ),
              const SizedBox(height: 16),
              _section('Ma\'lumot'),
              _SettingCard(
                icon: Icons.info_outline,
                title: 'Ilova haqida',
                subtitle: 'Versiya 1.0.0',
                onTap: () => _showAboutDialog(context),
              ),
              const SizedBox(height: 8),
              _SettingCard(
                icon: Icons.menu_book,
                title: 'Manba kitoblar',
                subtitle: 'Ilova qaysi kitoblardan foydalanadi',
                onTap: () => _showSourcesDialog(context),
              ),
              const SizedBox(height: 16),
              _section('Xavfli zona'),
              _SettingCard(
                icon: Icons.restart_alt,
                title: 'Statistikani tozalash',
                subtitle: 'Barcha XP va daraja o\'chiriladi',
                iconColor: AppColors.deepRed,
                onTap: () => _confirmReset(context),
              ),
              const SizedBox(height: 8),
              _SettingCard(
                icon: Icons.refresh,
                title: 'Onboarding\'ni qayta ko\'rsatish',
                subtitle: 'Birinchi marta tanishuv ekrani qayta ochiladi',
                onTap: () async {
                  final p = await SharedPreferences.getInstance();
                  await p.setBool('onboarding_done', false);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          'Ilovani qayta ishga tushiring — onboarding ko\'rinadi'),
                      backgroundColor: AppColors.emerald,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              const OrnamentDivider(),
              Center(
                child: Text(
                  'MNSM — AI Specialist',
                  style: GoogleFonts.merriweather(
                    color: AppColors.softBrown.withOpacity(0.6),
                    fontSize: 11,
                    letterSpacing: 3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _speedLabel(double v) {
    if (v < 0.3) return 'Juda sekin';
    if (v < 0.45) return 'Sekin';
    if (v < 0.55) return 'O\'rtacha';
    if (v < 0.7) return 'Tez';
    return 'Juda tez';
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8, top: 4),
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.merriweather(
            color: AppColors.emerald,
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.ivory,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: Text('Arab Mentor', style: AppTheme.uzbekTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Versiya 1.0.0', style: AppTheme.uzbekBody),
            const SizedBox(height: 8),
            Text(
              'Arab tilini 0 dan mukammallikkacha o\'rganish uchun mo\'ljallangan interaktiv ilova.',
              style: AppTheme.uzbekBody,
            ),
            const SizedBox(height: 12),
            Text('Powered by:',
                style: AppTheme.uzbekBody.copyWith(
                    fontSize: 11, color: AppColors.softBrown)),
            Text('MNSM — AI Specialist',
                style: GoogleFonts.merriweather(
                  fontWeight: FontWeight.bold,
                  color: AppColors.emerald,
                  letterSpacing: 2,
                )),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Yopish'),
          ),
        ],
      ),
    );
  }

  void _showSourcesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.ivory,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: Text('Manba kitoblar', style: AppTheme.uzbekTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SourceItem('1', 'M. Hasanov', 'Arab tili darslari'),
            _SourceItem('2', 'S. Bekpo\'lat', 'Mabdaun Nahv & Mabdaul Qiroat'),
            _SourceItem('3', 'D. N. Bodariy', 'Mukammal Sarf darsligi'),
            _SourceItem('4', 'TIU', 'Tarkib qoidalari'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Yopish'),
          ),
        ],
      ),
    );
  }

  void _confirmReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.ivory,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Statistikani tozalashga ishonchingiz komilmi?'),
        content: const Text(
            'Barcha XP, daraja va o\'rganilgan so\'zlar o\'chiriladi.\nBu amalni qaytarib bo\'lmaydi!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.deepRed),
            onPressed: () {
              context.read<ProgressService>().reset();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Statistika tozalandi'),
                  backgroundColor: AppColors.deepRed,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Tozalash'),
          ),
        ],
      ),
    );
  }
}

class _SettingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? iconColor;
  final Widget? trailing;
  final Widget? child;
  final VoidCallback? onTap;

  const _SettingCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor,
    this.trailing,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ic = iconColor ?? AppColors.emerald;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: ic.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: ic, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: AppTheme.uzbekBody.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            )),
                        Text(subtitle,
                            style: AppTheme.uzbekBody.copyWith(
                                fontSize: 12, color: AppColors.softBrown)),
                      ],
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
              if (child != null) ...[
                const SizedBox(height: 8),
                child!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SourceItem extends StatelessWidget {
  final String number;
  final String author;
  final String book;
  const _SourceItem(this.number, this.author, this.book);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.emerald,
            child: Text(number,
                style: GoogleFonts.amiri(
                    color: AppColors.goldLight,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(author,
                    style:
                        AppTheme.uzbekBody.copyWith(fontWeight: FontWeight.bold)),
                Text(book,
                    style: AppTheme.uzbekBody.copyWith(
                        fontSize: 12, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
