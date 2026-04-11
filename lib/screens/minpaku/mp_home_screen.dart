import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.grid_view_rounded, color: AppTheme.primary, size: 24),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: AppTheme.surface.withValues(alpha: 0.85),
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(color: Colors.transparent),
              ),
            ),
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Row(mainAxisSize: MainAxisSize.min, children: [
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
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const NotificationScreen())),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                _buildSearchBar(context),
                const SizedBox(height: 12),
                _buildPropertyTypes(context),
                const SizedBox(height: 20),
                _buildFeaturedBento(context),
                const SizedBox(height: 24),
                _buildNewArrivals(context),
                const SizedBox(height: 24),
                _buildAreaGuide(context),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
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
          child: Text(AppLocalizations.of(context)!.searchPlaceholder,
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
            Text(AppLocalizations.of(context)!.changeConditions,
                style: GoogleFonts.notoSansJp(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ]),
        ),
      ]),
    );
  }

  Widget _buildPropertyTypes(BuildContext context) {
    final types = [
      (Icons.temple_buddhist, AppLocalizations.of(context)!.catTraditional),
      (Icons.beach_access, AppLocalizations.of(context)!.catSeaside),
      (Icons.house, AppLocalizations.of(context)!.catHouse),
      (Icons.apartment, AppLocalizations.of(context)!.catApartment),
      (Icons.landscape, AppLocalizations.of(context)!.catMountain),
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
              Text(AppLocalizations.of(context)!.recommendedStays,
                  style: GoogleFonts.notoSansJp(
                      fontSize: 17, fontWeight: FontWeight.w900)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: AppTheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(AppLocalizations.of(context)!.lblLimited,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.onSecondaryContainer)),
              ),
            ]),
            Text(AppLocalizations.of(context)!.seeAll,
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
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MpPropertyDetailScreen())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(fit: StackFit.expand, children: [
                    CachedNetworkImage(imageUrl: Imgs.mpBig, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7)
                          ],
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
                          Text(AppLocalizations.of(context)!.mpFeature1Name.replaceFirst('、 ', '\n').replaceFirst(', ', '\n'),
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(AppLocalizations.of(context)!.mpFeature1Loc + '  ' + AppLocalizations.of(context)!.yen + '45,000〜',
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
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MpPropertyDetailScreen())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(fit: StackFit.expand, children: [
                    CachedNetworkImage(
                        imageUrl: Imgs.mpSmall, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7)
                          ],
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Text(AppLocalizations.of(context)!.mpFeature2Name.replaceAll(', ', '\n').replaceAll('、', '\n'),
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
        Text(AppLocalizations.of(context)!.newListings,
            style: GoogleFonts.notoSansJp(
                fontSize: 17, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        ...getMpProperties(AppLocalizations.of(context)!).take(3).map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MpPropertyDetailScreen(property: p))),
                child: _MpPropertyCard(property: p),
              ),
            )),
      ],
    );
  }

  Widget _buildAreaGuide(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.popularAreaGuide,
              style: GoogleFonts.notoSansJp(
                  fontSize: 17, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: Row(children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(fit: StackFit.expand, children: [
                    CachedNetworkImage(
                        imageUrl: Imgs.mpAreaKyoto, fit: BoxFit.cover),
                    Container(color: Colors.black.withOpacity(0.3)),
                    Center(
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text(AppLocalizations.of(context)!.mpAreaKyoto,
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
                        CachedNetworkImage(
                            imageUrl: Imgs.mpAreaTokyo, fit: BoxFit.cover),
                        Container(color: Colors.black.withOpacity(0.25)),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Text(AppLocalizations.of(context)!.mpAreaTokyo,
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
                        CachedNetworkImage(
                            imageUrl: Imgs.mpAreaOkinawa, fit: BoxFit.cover),
                        Container(color: Colors.black.withOpacity(0.25)),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Text(AppLocalizations.of(context)!.mpAreaOkinawa,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text(AppLocalizations.of(context)!.viewAllAreas,
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
                  child: CachedNetworkImage(
                      imageUrl: property.image,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) =>
                          Container(color: AppTheme.surfaceContainerHigh)),
                ),
                if (property.isNew)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(AppLocalizations.of(context)!.lblNew,
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
                                    fontSize: 9,
                                    color: AppTheme.onSurfaceVariant)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(AppLocalizations.of(context)!.yen + property.price,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.primary)),
                    Text(AppLocalizations.of(context)!.perNight,
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
