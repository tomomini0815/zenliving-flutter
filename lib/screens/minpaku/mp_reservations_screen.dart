import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import 'mp_reservation_confirm_screen.dart';
import 'mp_property_detail_screen.dart';

class MpReservationsScreen extends StatelessWidget {
  const MpReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppTheme.surface,
        elevation: 0,
        titleSpacing: 0,
        title: Text(l10n.mpReservationsTitle,
            style: GoogleFonts.notoSansJp(
                fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: AppTheme.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<ZenState>(
        builder: (context, state, _) {
          final dynamicReservations =
              state.reservations.where((r) => r['type'] == 'minpaku').toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Upcoming reservation card
              Text(l10n.mpUpcomingStay,
                  style: GoogleFonts.notoSansJp(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onSurfaceVariant,
                      letterSpacing: 1)),
              const SizedBox(height: 12),

              if (dynamicReservations.isNotEmpty) ...[
                ...dynamicReservations.map((res) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _ReservationCard(
                        name: res['name'],
                        dates: res['details'],
                        image: res['image'] ?? Imgs.mpReservation,
                        status: l10n.mpConfirmed,
                      ),
                    )),
              ] else ...[
                _ReservationCard(
                  name: l10n.mpMypagePropertyName,
                  dates: l10n.mpMypageDates,
                  image: Imgs.mpReservation,
                  status: l10n.mpConfirmed,
                ),
              ],

              const SizedBox(height: 28),
              // Quick reserve button
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
                ),
                child: Row(children: [
                  const Icon(Icons.add_circle_outline, color: AppTheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.mpNewReservation,
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primary)),
                          Text(l10n.mpNewReservationSub,
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 11,
                                  color: AppTheme.onSurfaceVariant)),
                        ]),
                  ),
                  const Icon(Icons.chevron_right, color: AppTheme.primary),
                ]),
              ),
              const SizedBox(height: 28),
              Text(l10n.mpPastStays,
                  style: GoogleFonts.notoSansJp(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onSurfaceVariant,
                      letterSpacing: 1)),
              const SizedBox(height: 12),
              _PastStayCard(
                name: l10n.mpAreaKyoto,
                dates: '2023-09-03 - 2023-09-05',
                price: '${l10n.yen}38,400',
                image: Imgs.mpAreaKyoto,
              ),
              const SizedBox(height: 12),
              _PastStayCard(
                name: l10n.mpAreaOkinawa,
                dates: '2023-07-20 - 2023-07-23',
                price: '${l10n.yen}112,500',
                image: Imgs.mpAreaOkinawa,
              ),
              const SizedBox(height: 80),
            ]),
          );
        },
      ),
    );
  }
}

class _ReservationCard extends StatelessWidget {
  final String name;
  final String dates;
  final String image;
  final String status;

  const _ReservationCard({
    required this.name,
    required this.dates,
    required this.image,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20)
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 130,
          width: double.infinity,
          child: Stack(fit: StackFit.expand, children: [
            CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Container(color: AppTheme.surfaceContainerHigh)),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(status,
                    style: GoogleFonts.notoSansJp(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary)),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name,
                style: GoogleFonts.notoSansJp(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(children: [
              const Icon(Icons.calendar_month,
                  size: 14, color: AppTheme.onSurfaceVariant),
              const SizedBox(width: 6),
              Text(dates,
                  style: GoogleFonts.notoSansJp(
                      fontSize: 12, color: AppTheme.onSurfaceVariant)),
            ]),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(l10n.mpViewDetails,
                    style: GoogleFonts.notoSansJp(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class _PastStayCard extends StatelessWidget {
  final String name;
  final String dates;
  final String price;
  final String image;
  const _PastStayCard({
    required this.name,
    required this.dates,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(children: [
        SizedBox(
          width: 96,
          child: CachedNetworkImage(
              imageUrl: image,
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
                Text(name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSansJp(
                        fontSize: 13, fontWeight: FontWeight.bold)),
                Text(dates,
                    style: GoogleFonts.notoSansJp(
                        fontSize: 11, color: AppTheme.onSurfaceVariant)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primary)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(l10n.mpWriteReview,
                          style: GoogleFonts.notoSansJp(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.onSurfaceVariant)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
