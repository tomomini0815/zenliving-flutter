import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import '../common/notification_screen.dart';
import 'mp_property_detail_screen.dart';

class MpSearchScreen extends StatefulWidget {
  const MpSearchScreen({super.key});
  @override
  State<MpSearchScreen> createState() => _MpSearchScreenState();
}

class _MpSearchScreenState extends State<MpSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _filter = 0;
  final _filters = ['全て', '古民家', '海沿い', '一軒家', '山・森'];
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = mpProperties.where((p) {
      final q = _query.toLowerCase();
      final nameMatch = p.name.toLowerCase().contains(q) ||
          p.location.toLowerCase().contains(q);
      final tagMatch = p.tags.any((t) => t.contains(q));
      
      // Basic category filter (if not "All")
      bool categoryMatch = true;
      if (_filter > 0) {
        categoryMatch = p.tags.contains(_filters[_filter]);
      }
      
      return (nameMatch || tagMatch) && categoryMatch;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        titleSpacing: 0,
        title: Text('宿泊先を探す',
            style: GoogleFonts.notoSansJp(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppTheme.onSurfaceVariant),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
          ),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.search, color: AppTheme.primary),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: 'エリア・キーワードから探す',
                    hintStyle: GoogleFonts.notoSansJp(
                        fontSize: 14, color: AppTheme.onSurfaceVariant),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.transparent,
                    filled: false,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  const Icon(Icons.tune, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text('条件変更',
                      style: GoogleFonts.notoSansJp(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ]),
              ),
            ]),
          ),
        ),
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filters.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _filter = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: _filter == i
                        ? AppTheme.primary
                        : AppTheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(_filters[i],
                      style: GoogleFonts.notoSansJp(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _filter == i
                              ? Colors.white
                              : AppTheme.onSurfaceVariant)),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: filtered.isEmpty
              ? Center(child: Text('該当する宿泊先がありません', style: GoogleFonts.notoSansJp(color: AppTheme.onSurfaceVariant)))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const Divider(
                      height: 24, color: AppTheme.outlineVariant, indent: 0),
                  itemBuilder: (_, i) {
                    final p = filtered[i];
                    return GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => MpPropertyDetailScreen(property: p))),
                      child: _MpListCard(property: p),
                    );
                  },
                ),
        ),
      ]),
    );
  }
}

class _MpListCard extends StatelessWidget {
  final MpProperty property;
  const _MpListCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return Consumer<ZenState>(builder: (_, state, __) {
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 110,
            height: 110,
            child: Image.network(property.image, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppTheme.surfaceContainerHigh)),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text(property.location,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.outline,
                          letterSpacing: 1))),
              GestureDetector(
                onTap: () => state.toggleFavorite(property.id),
                child: Icon(
                  state.isFavorite(property.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 20,
                  color: state.isFavorite(property.id)
                      ? AppTheme.error
                      : const Color(0xFFBDBDBD),
                ),
              ),
            ]),
            const SizedBox(height: 4),
            Text(property.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.notoSansJp(
                    fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 4,
              children: property.tags
                  .map((t) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: AppTheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(t,
                            style: GoogleFonts.notoSansJp(
                                fontSize: 9, color: AppTheme.onSurfaceVariant)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(property.price,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primary)),
                Text(' / 泊',
                    style: GoogleFonts.notoSansJp(
                        fontSize: 10,
                        color: AppTheme.outline,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ]),
        ),
      ]);
    });
  }
}
