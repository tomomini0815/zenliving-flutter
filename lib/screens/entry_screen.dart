import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../state/zen_state.dart';
import '../theme/app_theme.dart';
import '../data/sample_data.dart';
import 'main_shell.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCode =
        context.watch<ZenState>().locale.languageCode.toUpperCase();
    final l10n = AppLocalizations.of(context)!;

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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppTheme.outlineVariant.withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.language,
                              size: 16, color: AppTheme.primary),
                          const SizedBox(width: 8),
                          Text(languageCode,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.onSurface)),
                          const Icon(Icons.arrow_drop_down,
                              size: 20, color: AppTheme.onSurface),
                        ],
                      ),
                    ),
                    onSelected: (String value) {
                      context.read<ZenState>().setLocale(value);
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'ja',
                        child: Text('日本語 (Japan)'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'en',
                        child: Text('English (US)'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'zh',
                        child: Text('简体中文 (Chinese)'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'ko',
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
                  const Icon(Icons.home_work,
                      color: Color(0xFF1B5E20), size: 32),
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
                l10n.selectLifestyle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final commonCards = [
                      Expanded(
                        child: _ModeCard(
                          imageUrl: Imgs.reEntry,
                          badge: l10n.assetManagementBadge,
                          titleMain: l10n.realEstateModeMain,
                          titleSub: l10n.realEstateModeSub,
                          onTap: () => _selectMode(context, AppMode.realEstate),
                        ),
                      ),
                      const SizedBox(width: 16, height: 16),
                      Expanded(
                        child: _ModeCard(
                          imageUrl: Imgs.mpEntry,
                          badge: l10n.experienceBadge,
                          titleMain: l10n.minpakuModeMain,
                          titleSub: l10n.minpakuModeSub,
                          onTap: () => _selectMode(context, AppMode.minpaku),
                        ),
                      ),
                    ];
                    return constraints.maxWidth >= 600
                        ? Row(children: commonCards)
                        : Column(children: commonCards);
                  },
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
  final String titleMain;
  final String titleSub;
  final VoidCallback onTap;

  const _ModeCard({
    required this.imageUrl,
    required this.badge,
    required this.titleMain,
    required this.titleSub,
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
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) =>
                  Container(color: AppTheme.surfaceContainerHigh),
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
              right: 24,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
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
                              titleMain,
                              style: GoogleFonts.notoSansJp(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              titleSub,
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
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_forward, color: Colors.white, size: 24),
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
