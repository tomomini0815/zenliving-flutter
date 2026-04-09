import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import 'mp_reservation_confirm_screen.dart';

class MpPropertyDetailScreen extends StatelessWidget {
  final MpProperty? property;
  const MpPropertyDetailScreen({super.key, this.property});

  @override
  Widget build(BuildContext context) {
    final p = property ??
        MpProperty(
          id: 'mp_demo',
          name: '軽井沢の静寂に包まれるモダン和風邸宅',
          location: 'NAGANO / KARUIZAWA',
          price: '¥45,000',
          rating: 4.97,
          tags: ['森の中', '完全貸切', '暖炉'],
          image: Imgs.mpDetail,
        );

    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppTheme.surface,
            titleSpacing: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back, color: AppTheme.onSurface),
              ),
            ),
            actions: [
              Consumer<ZenState>(builder: (_, state, __) {
                return GestureDetector(
                  onTap: () => state.toggleFavorite(p.id),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle),
                    child: Icon(
                      state.isFavorite(p.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: state.isFavorite(p.id)
                          ? AppTheme.error
                          : AppTheme.onSurface,
                    ),
                  ),
                );
              }),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(p.image, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: AppTheme.surfaceContainerHigh)),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(p.location,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.outline,
                        letterSpacing: 2)),
                const SizedBox(height: 8),
                Text(p.name,
                    style: GoogleFonts.notoSansJp(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(children: [
                  const Icon(Icons.star_rounded,
                      size: 16, color: AppTheme.secondary),
                  const SizedBox(width: 4),
                  Text(p.rating.toStringAsFixed(2),
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text('(レビュー42件)',
                      style: GoogleFonts.notoSansJp(
                          fontSize: 12, color: AppTheme.onSurfaceVariant)),
                ]),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: p.tags
                      .map((t) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(t,
                                style: GoogleFonts.notoSansJp(
                                    fontSize: 12,
                                    color: AppTheme.onSurfaceVariant)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(children: [
                    _InfoRow(icon: Icons.calendar_month,
                        label: 'チェックイン', value: '15:00以降'),
                    const Divider(height: 20),
                    _InfoRow(icon: Icons.logout,
                        label: 'チェックアウト', value: '11:00まで'),
                    const Divider(height: 20),
                    _InfoRow(icon: Icons.group,
                        label: '最大宿泊人数', value: '4名'),
                    const Divider(height: 20),
                    _InfoRow(icon: Icons.smoking_rooms,
                        label: '禁煙', value: '全館禁煙'),
                  ]),
                ),
                const SizedBox(height: 20),
                Text('施設について',
                    style: GoogleFonts.notoSansJp(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text(
                  '自然の静寂の中に宿る、こだわり抜いた空間。地元の職人が手掛けた木造建築と、モダンなデザインが融合した一棟貸しの宿です。敷地内には無農薬の野菜畑があり、収穫体験もお楽しみいただけます。',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 13,
                      color: AppTheme.onSurfaceVariant,
                      height: 1.8),
                ),
                const SizedBox(height: 24),
                // Cancellation policy
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryContainer.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppTheme.secondary.withOpacity(0.2)),
                  ),
                  child: Row(children: [
                    const Icon(Icons.stars_rounded,
                        color: AppTheme.secondary, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('安心のキャンセル保証',
                                style: GoogleFonts.notoSansJp(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.secondary)),
                            const SizedBox(height: 2),
                            Text('チェックインの48時間前までであれば、全額返金が可能です。',
                                style: GoogleFonts.notoSansJp(
                                    fontSize: 11,
                                    color: AppTheme.onSurfaceVariant,
                                    height: 1.5)),
                          ]),
                    ),
                  ]),
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border(
              top: BorderSide(color: AppTheme.outlineVariant.withOpacity(0.3))),
        ),
        child: Row(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1泊あたり',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 11, color: AppTheme.onSurfaceVariant)),
              Text(p.price,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.primary)),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(
                      builder: (_) => MpReservationConfirmScreen(property: p))),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: Text('予約する',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 18, color: AppTheme.primary),
      const SizedBox(width: 10),
      Text(label,
          style: GoogleFonts.notoSansJp(
              fontSize: 12, color: AppTheme.onSurfaceVariant)),
      const Spacer(),
      Text(value,
          style: GoogleFonts.notoSansJp(
              fontSize: 13, fontWeight: FontWeight.bold)),
    ]);
  }
}
