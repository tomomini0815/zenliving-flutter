import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../data/sample_data.dart';
import 'mp_favorites_screen.dart';

class MpMypageScreen extends StatelessWidget {
  const MpMypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppTheme.surface,
        elevation: 0,
        titleSpacing: 0,
        title: Text(l10n.navMyPage,
            style: GoogleFonts.notoSansJp(
                fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined,
                color: AppTheme.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.surfaceContainerHigh,
                      image: const DecorationImage(
                        image: NetworkImage(Imgs.userAvatar),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          color: AppTheme.secondary.withOpacity(0.2), width: 2),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('TARO YAMADA',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.verified,
                                      size: 12,
                                      color: AppTheme.onSecondaryContainer),
                                  const SizedBox(width: 4),
                                  Text(l10n.mpMypageVerifiedMember,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              AppTheme.onSecondaryContainer)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('山田 太郎',
                            style: GoogleFonts.notoSansJp(
                                fontSize: 13,
                                color: AppTheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Upcoming Trip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.mpMypageUpcomingStay,
                      style: GoogleFonts.notoSansJp(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: AppTheme.outline)),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                Imgs.mpReservation,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(l10n.mpMypageConfirmed,
                                      style: GoogleFonts.notoSansJp(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.secondary)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.mpMypagePropertyName,
                                    style: GoogleFonts.notoSansJp(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        size: 14,
                                        color: AppTheme.onSurfaceVariant),
                                    const SizedBox(width: 4),
                                    Text(l10n.mpMypageDates,
                                        style: GoogleFonts.notoSansJp(
                                            fontSize: 11,
                                            color: AppTheme.onSurfaceVariant)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(l10n.mpMypageViewDetails,
                                    style: GoogleFonts.notoSansJp(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.secondary)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Main Menu
            _MenuSection(
              title: l10n.mpMypageReservationsSection,
              children: [
                _MenuItem(
                  icon: Icons.history,
                  title: l10n.mpMypagePastStays,
                ),
                _MenuItem(
                  icon: Icons.chat_bubble_outline,
                  title: l10n.mpMypageHostInquiry,
                  hasNotification: true,
                ),
                _MenuItem(
                  icon: Icons.favorite_border,
                  title: l10n.mpMypageFavoriteList,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MpFavoritesScreen()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _MenuSection(
              title: l10n.mpMypageSettingsSection,
              children: [
                _MenuItem(
                  icon: Icons.person_outline,
                  title: l10n.mpMypageAccountInfo,
                ),
                _MenuItem(
                  icon: Icons.payment,
                  title: l10n.mpMypagePayment,
                ),
                _MenuItem(
                  icon: Icons.help_outline,
                  title: l10n.mpMypageHelp,
                ),
                _MenuItem(
                  icon: Icons.article_outlined,
                  title: l10n.mpMypageTerms,
                ),
                _MenuItem(
                  icon: Icons.logout,
                  title: l10n.mpMypageLogout,
                  textColor: AppTheme.error,
                  showArrow: false,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'ZenLiving App v1.0.0',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12, color: AppTheme.outline),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _MenuSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(title,
              style: GoogleFonts.notoSansJp(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: AppTheme.outline)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1)
                  const Divider(height: 1, indent: 56, endIndent: 16),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool hasNotification;
  final Color? textColor;
  final bool showArrow;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.hasNotification = false,
    this.textColor,
    this.showArrow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: textColor != null
                    ? textColor!.withOpacity(0.1)
                    : AppTheme.surfaceContainerLow,
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  size: 20, color: textColor ?? AppTheme.onSurfaceVariant),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title,
                  style: GoogleFonts.notoSansJp(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor ?? AppTheme.onSurface)),
            ),
            if (hasNotification)
              Container(
                margin: const EdgeInsets.only(right: 12),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppTheme.error,
                  shape: BoxShape.circle,
                ),
              ),
            if (showArrow)
              const Icon(Icons.chevron_right,
                  color: AppTheme.outlineVariant, size: 20),
          ],
        ),
      ),
    );
  }
}
