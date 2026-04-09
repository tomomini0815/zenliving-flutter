import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../state/zen_state.dart';
import '../theme/app_theme.dart';
import '../data/sample_data.dart';
import 'main_shell.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: PopupMenuButton<String>(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.language, size: 16, color: AppTheme.primary),
                          const SizedBox(width: 8),
                          Text('JA', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.onSurface)),
                          const Icon(Icons.arrow_drop_down, size: 20, color: AppTheme.onSurface),
                        ],
                      ),
                    ),
                    onSelected: (String value) {
                      // Logic for language change if needed later
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'JA',
                        child: Text('日本語 (Japan)'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'EN',
                        child: Text('English (US)'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'ZH',
                        child: Text('简体中文 (Chinese)'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'KO',
                        child: Text('한국어 (Korean)'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.home_work, color: Color(0xFF1B5E20), size: 32),
                  const SizedBox(width: 12),
                  Text(
                    'ZenLiving',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'SELECT YOUR LIFESTYLE',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: _ModeCard(
                  imageUrl: Imgs.reEntry,
                  badge: 'Asset Management',
                  titleJp: '住まう',
                  titleEn: 'Real Estate',
                  onTap: () => _selectMode(context, AppMode.realEstate),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _ModeCard(
                  imageUrl: Imgs.mpEntry,
                  badge: 'Experience',
                  titleJp: '泊まる',
                  titleEn: 'Stay',
                  onTap: () => _selectMode(context, AppMode.minpaku),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _selectMode(BuildContext context, AppMode mode) {
    context.read<ZenState>().setMode(mode);
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => const MainShell(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String imageUrl;
  final String badge;
  final String titleJp;
  final String titleEn;
  final VoidCallback onTap;

  const _ModeCard({
    required this.imageUrl,
    required this.badge,
    required this.titleJp,
    required this.titleEn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppTheme.surfaceContainerHigh),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.65),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    badge.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        titleJp,
                        style: GoogleFonts.notoSansJp(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        titleEn,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
