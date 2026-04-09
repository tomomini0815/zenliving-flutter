import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import '../common/notification_screen.dart';
import 're_property_detail_screen.dart';

class ReHomeScreen extends StatelessWidget {
  const ReHomeScreen({super.key});

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
            shadowColor: Colors.black.withOpacity(0.05),
            title: Text(
              'ZenLiving',
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
                color: const Color(0xFF1B5E20),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: AppTheme.onSurfaceVariant),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                _buildSearchSection(),
                const SizedBox(height: 16),
                _buildCategoryGrid(),
                const SizedBox(height: 28),
                _buildFeaturedSection(),
                const SizedBox(height: 28),
                _buildNewListings(context),
                const SizedBox(height: 28),
                _buildAreaGuide(),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _SearchButton(icon: Icons.train, label: 'エリア・沿線から探す'),
          const SizedBox(height: 8),
          _SearchButton(icon: Icons.my_location, label: '現在地から探す'),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    const cats = [
      (Icons.apartment, '賃貸'),
      (Icons.location_city, 'マンション'),
      (Icons.home, '一戸建て'),
      (Icons.landscape, '土地'),
      (Icons.account_balance, '投資・事業用'),
      (Icons.handyman, 'リフォーム'),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        return GridView.count(
          crossAxisCount: isWide ? 6 : 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: isWide ? 1.5 : 1.6,
          children: cats
              .map((c) => _CategoryCard(icon: c.$1, label: c.$2))
              .toList(),
        );
      },
    );
  }

  Widget _buildFeaturedSection() {
    final items = [
      (Imgs.re1, '新築・築浅特集'),
      (Imgs.re2, '駅から徒歩5分以内'),
      (Imgs.re3, 'ペット相談可物件'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('おすすめの特集',
                style:
                    GoogleFonts.notoSansJp(fontSize: 17, fontWeight: FontWeight.bold)),
            Text('すべて見る',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 112,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) =>
                _FeaturedCard(imageUrl: items[i].$1, label: items[i].$2),
          ),
        ),
      ],
    );
  }

  Widget _buildNewListings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Text('新着物件',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: AppTheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(10)),
                child: Text('NEW',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.onSecondaryContainer)),
              ),
            ]),
            Text('条件を保存',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary)),
          ],
        ),
        const SizedBox(height: 12),
        ...reProperties.take(2).map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RePropertyDetailScreen(property: p))),
                child: _RePropertyCard(property: p),
              ),
            )),
      ],
    );
  }

  Widget _buildAreaGuide() {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 160,
            child: Image.network(Imgs.reArea, fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.6), colorBlendMode: BlendMode.lighten),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('人気のエリアガイド',
                    style: GoogleFonts.notoSansJp(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('恵比寿・代官山・中目黒エリアの\n住みやすさと家賃相場を徹底解説。',
                    style: GoogleFonts.notoSansJp(
                        fontSize: 11,
                        color: AppTheme.onSurfaceVariant,
                        height: 1.6)),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: const StadiumBorder(),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('ガイドを読む',
                      style: GoogleFonts.notoSansJp(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SearchButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.primary, size: 20),
              const SizedBox(width: 12),
              Text(label,
                  style: GoogleFonts.notoSansJp(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const _CategoryCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppTheme.primary, size: 22),
          const SizedBox(height: 4),
          Text(label,
              style: GoogleFonts.notoSansJp(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String label;
  const _FeaturedCard({required this.imageUrl, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 172,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppTheme.surfaceContainerHigh)),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class _RePropertyCard extends StatelessWidget {
  final ReProperty property;
  const _RePropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return Consumer<ZenState>(builder: (_, state, __) {
      return Container(
        height: 120,
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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(property.image, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: AppTheme.surfaceContainerHigh)),
                  if (property.isNew)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text('新着',
                            style: GoogleFonts.notoSansJp(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(property.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
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
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(property.price,
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.primary)),
                            Text('万円',
                                style: GoogleFonts.notoSansJp(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primary)),
                          ],
                        ),
                        Text(property.layout,
                            style: GoogleFonts.notoSansJp(
                                fontSize: 11, color: AppTheme.onSurfaceVariant)),
                        Text(property.station,
                            style: GoogleFonts.notoSansJp(
                                fontSize: 11, color: AppTheme.onSurfaceVariant)),
                      ],
                    ),
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
