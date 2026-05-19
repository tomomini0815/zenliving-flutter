import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../data/sample_data.dart';
import 're_favorites_screen.dart';

class ReMypageScreen extends StatelessWidget {
  const ReMypageScreen({super.key});

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
                          color: AppTheme.primary.withOpacity(0.2), width: 2),
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
                            Expanded(
                              child: Text('佐藤 健二 様',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.notoSansJp(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryContainer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star,
                                      size: 12,
                                      color: AppTheme.onPrimaryContainer),
                                  const SizedBox(width: 4),
                                  Text(l10n.reMypagePremiumMember,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.onPrimaryContainer)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('kenji.sato@example.com',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: AppTheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Quick Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ReFavoritesScreen()));
                      },
                      child: _StatCard(
                        icon: Icons.favorite,
                        label: l10n.reMypageStatFavorites,
                        value: '12',
                        unit: l10n.reMypageStatUnit,
                        iconColor: AppTheme.error,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.history,
                      label: l10n.reMypageStatRecent,
                      value: '24',
                      unit: l10n.reMypageStatUnit,
                      iconColor: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.bookmark,
                      label: l10n.reMypageStatSaved,
                      value: '3',
                      unit: l10n.reMypageStatUnit,
                      iconColor: AppTheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Main Menu
            _MenuSection(
              title: l10n.reMypageActivitySection,
              children: [
                _MenuItem(
                  icon: Icons.chat_bubble_outline,
                  title: l10n.reMypageInquiryHistory,
                  subtitle: l10n.reMypageInquirySubtitle,
                  hasNotification: true,
                ),
                _MenuItem(
                  icon: Icons.notifications_none,
                  title: l10n.reMypagePushNotif,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _MenuSection(
              title: l10n.reMypageSettingsSection,
              children: [
                _MenuItem(
                  icon: Icons.person_outline,
                  title: l10n.reMypageAccountInfo,
                ),
                _MenuItem(
                  icon: Icons.shield_outlined,
                  title: l10n.reMypagePrivacy,
                ),
                _MenuItem(
                  icon: Icons.help_outline,
                  title: l10n.reMypageHelp,
                ),
                _MenuItem(
                  icon: Icons.logout,
                  title: l10n.reMypageLogout,
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color iconColor;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onSurface)),
              const SizedBox(width: 2),
              Text(unit,
                  style: GoogleFonts.notoSansJp(
                      fontSize: 10, color: AppTheme.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 4),
          Text(label,
              style: GoogleFonts.notoSansJp(
                  fontSize: 11, color: AppTheme.onSurfaceVariant)),
        ],
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
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
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
  final String? subtitle;
  final bool hasNotification;
  final Color? textColor;
  final bool showArrow;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.hasNotification = false,
    this.textColor,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.notoSansJp(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: textColor ?? AppTheme.onSurface)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!,
                        style: GoogleFonts.notoSansJp(
                            fontSize: 12, color: AppTheme.primary)),
                  ],
                ],
              ),
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
