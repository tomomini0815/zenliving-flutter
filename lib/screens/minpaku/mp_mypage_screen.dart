import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../data/sample_data.dart';
import '../entry_screen.dart';
import '../common/notification_screen.dart';

class MpMypageScreen extends StatelessWidget {
  const MpMypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF2E7D32)),
          onPressed: () {},
        ),
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
                color: Color(0xFF0D631B)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),
          // Profile
          Row(children: [
            Stack(children: [
              ClipOval(
                child: Image.network(Imgs.userAvatar,
                    width: 80, height: 80, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                        width: 80,
                        height: 80,
                        color: AppTheme.surfaceContainerHigh,
                        child: const Icon(Icons.person, size: 40))),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.surface, width: 2)),
                  child: const Icon(Icons.edit, size: 12, color: Colors.white),
                ),
              ),
            ]),
            const SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('佐藤 健一',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              Text('sato.k@example.com',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 12, color: AppTheme.onSurfaceVariant)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.verified_user,
                      size: 12, color: AppTheme.primary),
                  const SizedBox(width: 4),
                  Text('Verified Member',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                          letterSpacing: 0.5)),
                ]),
              ),
            ]),
          ]),
          const SizedBox(height: 20),
          // Upcoming stay card
          Text('次回の滞在',
              style: GoogleFonts.notoSansJp(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.onSurfaceVariant,
                  letterSpacing: 2)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16)
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Stack(fit: StackFit.expand, children: [
                  Image.network(Imgs.mpReservation, fit: BoxFit.cover),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('確定済み',
                          style: GoogleFonts.notoSansJp(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary)),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('鎌倉 隠れ家ヴィラ',
                      style: GoogleFonts.notoSansJp(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.calendar_month,
                        size: 14, color: AppTheme.onSurfaceVariant),
                    const SizedBox(width: 6),
                    Text('2023年11月12日 - 11月14日 (2泊)',
                        style: GoogleFonts.notoSansJp(
                            fontSize: 12, color: AppTheme.onSurfaceVariant)),
                  ]),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('予約詳細を見る',
                          style: GoogleFonts.notoSansJp(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
          const SizedBox(height: 24),
          // Menu sections
          Text('予約とアクティビティ',
              style: GoogleFonts.notoSansJp(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.onSurfaceVariant,
                  letterSpacing: 2)),
          const SizedBox(height: 10),
          _buildMenuGroup([
            _MenuTile(icon: Icons.history, label: '過去の滞在履歴'),
            _MenuTile(icon: Icons.chat_bubble, label: 'ホストへの問い合わせ', badge: '2'),
            _MenuTile(icon: Icons.favorite, label: 'お気に入りリスト'),
          ]),
          const SizedBox(height: 20),
          Text('設定とサポート',
              style: GoogleFonts.notoSansJp(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.onSurfaceVariant,
                  letterSpacing: 2)),
          const SizedBox(height: 10),
          _buildMenuGroup([
            _MenuTile(icon: Icons.person, label: 'アカウント情報'),
            _MenuTile(icon: Icons.payment, label: 'お支払い方法'),
            _MenuTile(icon: Icons.help, label: 'ヘルプ・お問い合わせ'),
          ]),
          const SizedBox(height: 12),
          _buildMenuGroup([
            _MenuTile(icon: Icons.policy, label: '利用規約とプライバシーポリシー'),
          ]),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const EntryScreen()),
                (route) => false,
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.error,
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppTheme.errorContainer.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: Text('ログアウト',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text('VERSION 2.4.0',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: AppTheme.outline.withOpacity(0.5))),
          ),
          const SizedBox(height: 80),
        ]),
      ),
    );
  }

  Widget _buildMenuGroup(List<_MenuTile> tiles) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: tiles.asMap().entries.map((e) {
          final i = e.key;
          final tile = e.value;
          return Column(children: [
            if (i > 0)
              Divider(
                  height: 1,
                  indent: 56,
                  color: AppTheme.outlineVariant.withOpacity(0.3)),
            ListTile(
              leading: Icon(tile.icon, color: AppTheme.primary, size: 22),
              title: Text(tile.label,
                  style: GoogleFonts.notoSansJp(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                if (tile.badge != null)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        color: AppTheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(tile.badge!,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.onSecondaryContainer)),
                  ),
                const Icon(Icons.chevron_right,
                    color: AppTheme.outlineVariant, size: 20),
              ]),
              onTap: () {},
            ),
          ]);
        }).toList(),
      ),
    );
  }
}

class _MenuTile {
  final IconData icon;
  final String label;
  final String? badge;
  const _MenuTile({required this.icon, required this.label, this.badge});
}
