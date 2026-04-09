import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../data/sample_data.dart';
import '../entry_screen.dart';
import '../common/notification_screen.dart';

class ReMypageScreen extends StatelessWidget {
  const ReMypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        titleSpacing: 0,
        title: Row(children: [
          const Icon(Icons.home_work, color: Color(0xFF1B5E20), size: 20),
          const SizedBox(width: 8),
          Text('ZenLiving',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B5E20))),
        ]),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: AppTheme.onSurfaceVariant),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16)
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Image.network(Imgs.userAvatar,
                            width: 64, height: 64, fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                                width: 64,
                                height: 64,
                                color: AppTheme.surfaceContainerHigh,
                                child: const Icon(Icons.person))),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Icon(Icons.verified,
                              size: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('佐藤 健二 様',
                            style: GoogleFonts.notoSansJp(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('PREMIUM MEMBER',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.onPrimaryContainer)),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppTheme.outlineVariant),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Stats
            Row(
              children: [
                Expanded(child: _StatCard(label: 'お気に入り', value: '12', unit: '件')),
                const SizedBox(width: 8),
                Expanded(child: _StatCard(label: '最近見た', value: '24', unit: '件')),
                const SizedBox(width: 8),
                Expanded(child: _StatCard(label: '保存条件', value: '5', unit: '件')),
              ],
            ),
            const SizedBox(height: 20),
            // Activity Section
            _SectionLabel(label: 'ACTIVITY'),
            const SizedBox(height: 8),
            _MenuGroup(items: [
              _MenuItem(
                icon: Icons.chat_bubble_outline,
                label: 'お問い合わせ履歴',
                subtitle: '担当者からの返信があります',
                badge: '2 NEW',
              ),
            ]),
            const SizedBox(height: 16),
            _SectionLabel(label: 'SETTINGS'),
            const SizedBox(height: 8),
            _MenuGroup(items: [
              _MenuItem(icon: Icons.notifications_active_outlined, label: 'プッシュ通知設定'),
              _MenuItem(icon: Icons.account_circle_outlined, label: 'アカウント情報'),
              _MenuItem(icon: Icons.policy_outlined, label: 'プライバシーポリシー'),
              _MenuItem(icon: Icons.help_outline, label: 'ヘルプ・お問い合わせ'),
              _MenuItem(
                icon: Icons.logout,
                label: 'ログアウト',
                isDestructive: true,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const EntryScreen()),
                    (route) => false,
                  );
                },
              ),
            ]),
            const SizedBox(height: 24),
            Opacity(
              opacity: 0.25,
              child: Column(children: [
                Text('ZENLIVING APP',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
                Text('VERSION 5.0.0',
                    style:
                        GoogleFonts.plusJakartaSans(fontSize: 10, letterSpacing: 1)),
              ]),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  const _StatCard({required this.label, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text(label,
            style: GoogleFonts.notoSansJp(
                fontSize: 10, color: AppTheme.onSurfaceVariant)),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(value,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary)),
            Text(unit,
                style: GoogleFonts.notoSansJp(
                    fontSize: 10, color: AppTheme.onSurfaceVariant)),
          ],
        ),
      ]),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(label,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: AppTheme.onSurfaceVariant)),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final String? subtitle;
  final String? badge;
  final bool isDestructive;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    this.subtitle,
    this.badge,
    this.isDestructive = false,
    this.onTap,
  });
}

class _MenuGroup extends StatelessWidget {
  final List<_MenuItem> items;
  const _MenuGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final i = e.key;
          final item = e.value;
          return Column(
            children: [
              if (i > 0)
                Divider(
                    height: 1,
                    indent: 54,
                    color: AppTheme.outlineVariant.withOpacity(0.3)),
              ListTile(
                leading: Icon(item.icon,
                    color: item.isDestructive ? AppTheme.error : AppTheme.primary,
                    size: 22),
                title: Text(item.label,
                    style: GoogleFonts.notoSansJp(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: item.isDestructive
                            ? AppTheme.error
                            : AppTheme.onSurface)),
                subtitle: item.subtitle != null
                    ? Text(item.subtitle!,
                        style: GoogleFonts.notoSansJp(
                            fontSize: 11, color: AppTheme.onSurfaceVariant))
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.badge != null)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: AppTheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(item.badge!,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.onSecondaryContainer)),
                      ),
                    Icon(Icons.chevron_right,
                        color: AppTheme.outlineVariant.withOpacity(0.7), size: 20),
                  ],
                ),
                onTap: item.onTap ?? () {},
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
