import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import 'mp_property_detail_screen.dart';

class MpFavoritesScreen extends StatelessWidget {
  const MpFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        title: Text('お気に入り',
            style: GoogleFonts.notoSansJp(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: Consumer<ZenState>(builder: (_, state, __) {
        final favs = mpProperties.where((p) => state.isFavorite(p.id)).toList();
        if (favs.isEmpty) {
          return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.favorite_outline,
                  size: 64, color: AppTheme.outlineVariant),
              const SizedBox(height: 16),
              Text('お気に入りはまだありません',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 15,
                      color: AppTheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Text('気に入った宿泊先をハートで保存しましょう',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 12, color: AppTheme.onSurfaceVariant)),
            ]),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: favs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (_, i) {
            final p = favs[i];
            return GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(
                      builder: (_) => MpPropertyDetailScreen(property: p))),
              child: _FavCard(
                property: p,
                onRemove: () => state.toggleFavorite(p.id),
              ),
            );
          },
        );
      }),
    );
  }
}

class _FavCard extends StatelessWidget {
  final MpProperty property;
  final VoidCallback onRemove;
  const _FavCard({required this.property, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 160,
          width: double.infinity,
          child: Stack(fit: StackFit.expand, children: [
            Image.network(property.image, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppTheme.surfaceContainerHigh)),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.favorite, color: AppTheme.error, size: 18),
                ),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(property.location,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.outline,
                        letterSpacing: 1)),
                Row(children: [
                  const Icon(Icons.star_rounded, size: 12, color: AppTheme.secondary),
                  const SizedBox(width: 2),
                  Text(property.rating.toStringAsFixed(2),
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10, fontWeight: FontWeight.bold)),
                ]),
              ],
            ),
            const SizedBox(height: 4),
            Text(property.name,
                style: GoogleFonts.notoSansJp(
                    fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(property.price,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primary)),
                Text(' / 泊',
                    style: GoogleFonts.notoSansJp(
                        fontSize: 11,
                        color: AppTheme.outline,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
