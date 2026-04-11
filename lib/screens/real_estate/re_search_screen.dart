import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import '../common/notification_screen.dart';
import 're_property_detail_screen.dart';

class ReSearchScreen extends StatefulWidget {
  const ReSearchScreen({super.key});

  @override
  State<ReSearchScreen> createState() => _ReSearchScreenState();
}

class _ReSearchScreenState extends State<ReSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProperties = getReProperties(AppLocalizations.of(context)!).where((p) {
      final q = _query.toLowerCase();
      return p.name.toLowerCase().contains(q) ||
          p.station.toLowerCase().contains(q) ||
          p.layout.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppTheme.surface,
        elevation: 0,
        titleSpacing: 0,
        title: Text(AppLocalizations.of(context)!.titleSearchProperties,
            style: GoogleFonts.notoSansJp(
                fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: AppTheme.onSurfaceVariant),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const NotificationScreen())),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
                        child: Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.search, color: AppTheme.primary),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _query = v),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.searchPlaceholder,
                      hintMaxLines: 1,
                      hintStyle: GoogleFonts.notoSansJp(
                          fontSize: 14, color: AppTheme.onSurfaceVariant),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppTheme.primary, borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: [
                      const Icon(Icons.tune, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(AppLocalizations.of(context)!.changeConditions,
                          style: GoogleFonts.notoSansJp(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          Expanded(
            child: filteredProperties.isEmpty
                ? Center(
                    child: Text('該当する物件が見つかりませんでした',
                        style: GoogleFonts.notoSansJp(
                            color: AppTheme.onSurfaceVariant)))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredProperties.length,
                    separatorBuilder: (_, __) => const Divider(
                        height: 24, color: AppTheme.outlineVariant, indent: 0),
                    itemBuilder: (_, i) {
                      final p = filteredProperties[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    RePropertyDetailScreen(property: p))),
                        child: _SearchResultCard(property: p),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  final ReProperty property;
  const _SearchResultCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return Consumer<ZenState>(builder: (_, state, __) {
      return Container(
        height: 116,
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 110,
              child: CachedNetworkImage(
                  imageUrl: property.image,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) =>
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
                        onTap: () => state.toggleFavorite(property.id),
                        child: Icon(
                          state.isFavorite(property.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: state.isFavorite(property.id)
                              ? AppTheme.error
                              : const Color(0xFFBDBDBD),
                          size: 20,
                        ),
                      ),
                    ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  fontSize: 11,
                                  color: AppTheme.onSurfaceVariant)),
                          Text(property.station,
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 11,
                                  color: AppTheme.onSurfaceVariant)),
                        ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
