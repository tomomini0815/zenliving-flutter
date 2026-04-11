import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import '../success_screen.dart';

class ReReservationConfirmScreen extends StatefulWidget {
  final ReProperty? property;
  const ReReservationConfirmScreen({super.key, this.property});

  @override
  State<ReReservationConfirmScreen> createState() =>
      _ReReservationConfirmScreenState();
}

class _ReReservationConfirmScreenState
    extends State<ReReservationConfirmScreen> {
  int _paymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('申し込み内容の確認',
            style: GoogleFonts.notoSansJp(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: CachedNetworkImage(
                          imageUrl: Imgs.re4, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('賃貸マンション',
                            style: GoogleFonts.notoSansJp(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primary)),
                        const SizedBox(height: 4),
                        Text(widget.property?.name ?? 'パークアクシス代官山',
                            style: GoogleFonts.notoSansJp(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Row(children: [
                          const Icon(Icons.grid_view,
                              size: 14, color: AppTheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(widget.property?.layout ?? '1LDK / 42.5m²',
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 12,
                                  color: AppTheme.onSurfaceVariant)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('申込者情報',
                style: GoogleFonts.notoSansJp(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildFormField('氏名（漢字）', '山田 太郎'),
            const SizedBox(height: 12),
            _buildFormField('氏名（ローマ字）', 'YAMADA TARO'),
            const SizedBox(height: 12),
            _buildFormField('メールアドレス', 'yamada@example.com'),
            const SizedBox(height: 12),
            _buildFormField('電話番号', '090-1234-5678'),
            const SizedBox(height: 24),
            Text('お支払い方法',
                style: GoogleFonts.notoSansJp(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildPaymentOption(
                0, Icons.credit_card, 'クレジットカード', 'VISA, Mastercard, AMEX'),
            const SizedBox(height: 8),
            _buildPaymentOption(
                1, Icons.account_balance, '銀行振込', '振込手数料はお客様負担となります'),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.88),
          border: Border(
              top: BorderSide(color: AppTheme.outlineVariant.withOpacity(0.3))),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('月額賃料（税込）',
                    style: GoogleFonts.notoSansJp(
                        fontSize: 12, color: AppTheme.onSurfaceVariant)),
                Text('${widget.property?.price ?? '18.5'}万円',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primary)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Consumer<ZenState>(
                builder: (context, state, _) => ElevatedButton(
                  onPressed: () {
                    state.addReservation({
                      'id': 're_${DateTime.now().millisecondsSinceEpoch}',
                      'type': 'real_estate',
                      'name': widget.property?.name ?? 'パークアクシス代官山',
                      'price': widget.property?.price ?? '18.5',
                      'date': DateTime.now().toIso8601String(),
                      'details': widget.property?.layout ?? '1LDK / 42.5m²',
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const SuccessScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text('申し込みを確定する',
                      style: GoogleFonts.notoSansJp(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.notoSansJp(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.onSurfaceVariant)),
        const SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.notoSansJp(
                fontSize: 14, color: AppTheme.onSurfaceVariant),
            filled: true,
            fillColor: AppTheme.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
      int index, IconData icon, String title, String subtitle) {
    final selected = _paymentMethod == index;
    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.surfaceContainerLowest
              : AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppTheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: selected ? AppTheme.primary : AppTheme.onSurfaceVariant),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.notoSansJp(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style: GoogleFonts.notoSansJp(
                          fontSize: 11, color: AppTheme.onSurfaceVariant)),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? AppTheme.primary : AppTheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
