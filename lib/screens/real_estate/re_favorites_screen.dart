import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import 're_property_detail_screen.dart';

class ReFavoritesScreen extends StatelessWidget {
  const ReFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        titleSpacing: 0,
        title: Text('保存済み物件',
            style: GoogleFonts.notoSansJp(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: Consumer<ZenState>(builder: (_, state, __) {
        final favs = reProperties.where((p) => state.isFavorite(p.id)).toList();
        if (favs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.favorite_outline,
                    size: 64, color: AppTheme.outlineVariant),
                const SizedBox(height: 16),
                Text('保存済み物件はありません',
                    style: GoogleFonts.notoSansJp(
                        fontSize: 15,
                        color: AppTheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Text('気になる物件をお気に入りに追加しましょう',
                    style: GoogleFonts.notoSansJp(
                        fontSize: 12, color: AppTheme.onSurfaceVariant)),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: favs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final p = favs[i];
            return GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(
                      builder: (_) => RePropertyDetailScreen(property: p))),
              child: _FavoriteCard(property: p, onRemove: () => state.toggleFavorite(p.id)),
            );
          },
        );
      }),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final ReProperty property;
  final VoidCallback onRemove;
  const _FavoriteCard({required this.property, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Image.network(property.image, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppTheme.surfaceContainerHigh)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Expanded(
                        child: Text(property.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.notoSansJp(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    GestureDetector(
                      onTap: onRemove,
                      child: const Icon(Icons.favorite,
                          color: AppTheme.error, size: 20),
                    ),
                  ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(property.price,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.primary)),
                        Text('万円',
                            style: GoogleFonts.notoSansJp(
                                fontSize: 10,
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(property.layout,
                        style: GoogleFonts.notoSansJp(
                            fontSize: 11, color: AppTheme.onSurfaceVariant)),
                    Text(property.station,
                        style: GoogleFonts.notoSansJp(
                            fontSize: 11, color: AppTheme.onSurfaceVariant)),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
