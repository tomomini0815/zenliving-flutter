import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import 're_reservation_confirm_screen.dart';

class RePropertyDetailScreen extends StatelessWidget {
  final ReProperty? property;
  const RePropertyDetailScreen({super.key, this.property});

  @override
  Widget build(BuildContext context) {
    final p = property ??
        ReProperty(
          id: 're_demo',
          name: 'パークアクシス代官山',
          price: '18.5',
          layout: '1LDK / 42.5m²',
          station: '代官山駅 徒歩4分',
          image: Imgs.re4,
          isNew: true,
        );

    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppTheme.surface,
            titleSpacing: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle),
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
                      color: state.isFavorite(p.id) ? AppTheme.error : AppTheme.onSurface,
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
                if (p.isNew)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text('新着物件',
                        style: GoogleFonts.notoSansJp(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.onPrimaryContainer)),
                  ),
                Text(p.name,
                    style: GoogleFonts.notoSansJp(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(p.price,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.primary)),
                    Text('万円 / 月',
                        style: GoogleFonts.notoSansJp(
                            fontSize: 14, color: AppTheme.primary,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      _InfoRow(icon: Icons.grid_view, label: '間取り・広さ', value: p.layout),
                      const Divider(height: 20),
                      _InfoRow(
                          icon: Icons.directions_walk,
                          label: '最寄り駅',
                          value: p.station),
                      const Divider(height: 20),
                      _InfoRow(
                          icon: Icons.calendar_month,
                          label: '築年数',
                          value: '築3年（2021年竣工）'),
                      const Divider(height: 20),
                      _InfoRow(
                          icon: Icons.pets,
                          label: 'ペット',
                          value: '相談可'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text('物件について',
                    style: GoogleFonts.notoSansJp(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text(
                  'この物件は都心の利便性と静かな住環境を両立させた、こだわりの設計が施されたレジデンスです。天井高2.5mの開放感あるリビング、大型の窓から差し込む自然光が心地よい空間を演出します。',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 13,
                      color: AppTheme.onSurfaceVariant,
                      height: 1.8),
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.88),
          border: Border(
              top: BorderSide(color: AppTheme.outlineVariant.withOpacity(0.3))),
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('月額賃料', style: GoogleFonts.notoSansJp(fontSize: 11, color: AppTheme.onSurfaceVariant)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(p.price,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.primary)),
                    Text('万円',
                        style: GoogleFonts.notoSansJp(
                            fontSize: 11, color: AppTheme.primary,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ReReservationConfirmScreen(property: p))),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: Text('内見・申し込む',
                    style: GoogleFonts.notoSansJp(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
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
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.primary),
        const SizedBox(width: 10),
        Text(label,
            style: GoogleFonts.notoSansJp(
                fontSize: 12, color: AppTheme.onSurfaceVariant)),
        const Spacer(),
        Text(value,
            style: GoogleFonts.notoSansJp(
                fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
