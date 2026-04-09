import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import '../common/notification_screen.dart';
import 'mp_property_detail_screen.dart';

class MpHomeScreen extends StatelessWidget {
  const MpHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppTheme.surface,
            elevation: 0,
            scrolledUnderElevation: 0.5,
            title: Row(children: [
              const Icon(Icons.home_work, color: Color(0xFF1B5E20), size: 22),
              const SizedBox(width: 8),
              Text(
                'ZenLiving',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B5E20),
                ),
              ),
            ]),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Color(0xFF2E7D32)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                _buildSearchBar(),
                const SizedBox(height: 12),
                _buildPropertyTypes(),
                const SizedBox(height: 20),
                _buildFeaturedBento(context),
                const SizedBox(height: 24),
                _buildNewArrivals(context),
                const SizedBox(height: 24),
                _buildAreaGuide(),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
          child: Text('エリア・キーワードから探す',
              style: GoogleFonts.notoSansJp(
                  fontSize: 14, color: AppTheme.onSurfaceVariant)),
        ),
        Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
              color: AppTheme.primary, borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            const Icon(Icons.tune, color: Colors.white, size: 16),
            const SizedBox(width: 4),
            Text('条件変更',
                style: GoogleFonts.notoSansJp(
                    fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
          ]),
        ),
      ]),
    );
  }

  Widget _buildPropertyTypes() {
    const types = [
      (Icons.temple_buddhist, '古民家'),
      (Icons.beach_access, '海沿い'),
      (Icons.house, '一軒家'),
      (Icons.apartment, 'アパート'),
      (Icons.landscape, '山・森'),
    ];
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                shape: BoxShape.circle,
              ),
              child: Icon(types[i].$1, color: AppTheme.primary, size: 24),
            ),
            const SizedBox(height: 6),
            Text(types[i].$2,
                style: GoogleFonts.notoSansJp(
                    fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedBento(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Text('今月の推奨ステイ',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 17, fontWeight: FontWeight.w900)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: AppTheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(10)),
                child: Text('LIMITED',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.onSecondaryContainer)),
              ),
            ]),
            Text('すべて見る',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 190,
          child: Row(children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MpPropertyDetailScreen())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(fit: StackFit.expand, children: [
                    Image.network(Imgs.mpBig, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('建築家と建てる、\n静寂の森の隠れ家',
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SizedBox(height: 4),
                          Text('長野県・軽井沢  ¥45,000〜',
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.white70)),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MpPropertyDetailScreen())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(fit: StackFit.expand, children: [
                    Image.network(Imgs.mpSmall, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Text('波音と目覚める\n朝食付きヴィラ',
                          style: GoogleFonts.notoSansJp(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildNewArrivals(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('新着物件情報',
            style: GoogleFonts.notoSansJp(
                fontSize: 17, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        ...mpProperties.take(3).map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => MpPropertyDetailScreen(property: p))),
                child: _MpPropertyCard(property: p),
              ),
            )),
      ],
    );
  }

  Widget _buildAreaGuide() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('人気のエリアガイド',
              style:
                  GoogleFonts.notoSansJp(fontSize: 17, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: Row(children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(fit: StackFit.expand, children: [
                    Image.network(Imgs.mpAreaKyoto, fit: BoxFit.cover),
                    Container(color: Colors.black.withOpacity(0.3)),
                    Center(
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text('京都・東山',
                            style: GoogleFonts.notoSansJp(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 4)),
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Stack(fit: StackFit.expand, children: [
                        Image.network(Imgs.mpAreaTokyo, fit: BoxFit.cover),
                        Container(color: Colors.black.withOpacity(0.25)),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Text('東京・渋谷',
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Stack(fit: StackFit.expand, children: [
                        Image.network(Imgs.mpAreaOkinawa, fit: BoxFit.cover),
                        Container(color: Colors.black.withOpacity(0.25)),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Text('沖縄・恩納村',
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ]),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primary,
                side: const BorderSide(color: AppTheme.primary),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text('エリア一覧を見る',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 13, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MpPropertyCard extends StatelessWidget {
  final MpProperty property;
  const _MpPropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return Consumer<ZenState>(builder: (_, state, __) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                SizedBox(
                  width: 110,
                  height: 110,
                  child: Image.network(property.image, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: AppTheme.surfaceContainerHigh)),
                ),
                if (property.isNew)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('NEW',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.onPrimaryContainer)),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(property.location,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.outline,
                              letterSpacing: 1)),
                    ),
                    Row(children: [
                      const Icon(Icons.star_rounded,
                          size: 12, color: AppTheme.secondary),
                      const SizedBox(width: 2),
                      Text(property.rating.toStringAsFixed(2),
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10, fontWeight: FontWeight.bold)),
                    ]),
                  ],
                ),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
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
              ],
            ),
          ),
        ],
      );
    });
  }
}
