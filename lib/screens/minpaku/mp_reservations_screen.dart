import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import 'mp_reservation_confirm_screen.dart';
import 'mp_property_detail_screen.dart';

class MpReservationsScreen extends StatelessWidget {
  const MpReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        titleSpacing: 0,
        title: Text('予約済み',
            style: GoogleFonts.notoSansJp(fontWeight: FontWeight.bold, fontSize: 18)),
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
          final dynamicReservations = state.reservations
              .where((r) => r['type'] == 'minpaku')
              .toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Upcoming reservation card
              Text('次回の滞在',
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
                    status: '確定済み',
                  ),
                )),
              ] else ...[
                _ReservationCard(
                  name: '鎌倉 隠れ家ヴィラ',
                  dates: '2023年11月12日 - 11月14日 (2泊)',
                  image: Imgs.mpReservation,
                  status: '確定済み',
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
                          Text('新しい宿泊先を予約する',
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 14, fontWeight: FontWeight.bold,
                                  color: AppTheme.primary)),
                          Text('お好みの宿泊先を探しましょう',
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 11, color: AppTheme.onSurfaceVariant)),
                        ]),
                  ),
                  const Icon(Icons.chevron_right, color: AppTheme.primary),
                ]),
              ),
              const SizedBox(height: 28),
              Text('過去の滞在',
                  style: GoogleFonts.notoSansJp(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onSurfaceVariant,
                      letterSpacing: 1)),
              const SizedBox(height: 12),
              _PastStayCard(
                name: '京都・東山の古民家',
                dates: '2023年9月3日 - 9月5日',
                price: '¥38,400',
                image: Imgs.mpAreaKyoto,
              ),
              const SizedBox(height: 12),
              _PastStayCard(
                name: '沖縄・恩納村オーシャンヴィラ',
                dates: '2023年7月20日 - 7月23日',
                price: '¥112,500',
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
            Image.network(image, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppTheme.surfaceContainerHigh)),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    child: Text('予約詳細を見る',
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
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(children: [
        SizedBox(
          width: 96,
          child: Image.network(image, fit: BoxFit.cover,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('レビューを書く',
                          style: GoogleFonts.notoSansJp(
                              fontSize: 10, fontWeight: FontWeight.bold,
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
