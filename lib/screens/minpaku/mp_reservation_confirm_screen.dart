import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../state/zen_state.dart';
import '../../data/sample_data.dart';
import '../success_screen.dart';

class MpReservationConfirmScreen extends StatefulWidget {
  final MpProperty? property;
  const MpReservationConfirmScreen({super.key, this.property});

  @override
  State<MpReservationConfirmScreen> createState() =>
      _MpReservationConfirmScreenState();
}

class _MpReservationConfirmScreenState
    extends State<MpReservationConfirmScreen> {
  int _payment = 0;

  @override
  Widget build(BuildContext context) {
    final p = widget.property;
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('予約内容を確認する',
            style: GoogleFonts.notoSansJp(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: Color(0xFF0D631B)),
            onPressed: () {},
          ),
        ],
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
              child: Column(children: [
                Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.network(
                          p?.image ?? Imgs.mpDetail, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Villa Type A',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.onSurfaceVariant)),
                          const SizedBox(height: 4),
                          Text(p?.name ?? '軽井沢の静寂に包まれるモダン和風邸宅',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.notoSansJp(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(children: [
                            const Icon(Icons.calendar_month,
                                size: 14, color: AppTheme.onSurfaceVariant),
                            const SizedBox(width: 4),
                            Text('2024年11月15日 - 11月18日',
                                style: GoogleFonts.notoSansJp(
                                    fontSize: 11,
                                    color: AppTheme.onSurfaceVariant)),
                          ]),
                          const SizedBox(height: 4),
                          Row(children: [
                            const Icon(Icons.group,
                                size: 14, color: AppTheme.onSurfaceVariant),
                            const SizedBox(width: 4),
                            Text('ゲスト2名',
                                style: GoogleFonts.notoSansJp(
                                    fontSize: 11,
                                    color: AppTheme.onSurfaceVariant)),
                          ]),
                        ]),
                  ),
                ]),
              ]),
            ),
            const SizedBox(height: 24),
            Text('ゲスト情報入力',
                style: GoogleFonts.notoSansJp(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _FormField(label: '姓（ローマ字）', hint: 'YAMADA')),
              const SizedBox(width: 12),
              Expanded(child: _FormField(label: '名（ローマ字）', hint: 'TARO')),
            ]),
            const SizedBox(height: 12),
            _FormField(label: 'メールアドレス', hint: 'example@zenliving.jp'),
            const SizedBox(height: 12),
            _FormField(label: '電話番号', hint: '09012345678'),
            const SizedBox(height: 24),
            Text('お支払い方法',
                style: GoogleFonts.notoSansJp(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _PaymentOption(
              index: 0,
              selected: _payment,
              icon: Icons.credit_card,
              title: 'クレジットカード',
              subtitle: 'VISA, Mastercard, AMEX',
              onTap: () => setState(() => _payment = 0),
            ),
            const SizedBox(height: 8),
            _PaymentOption(
              index: 1,
              selected: _payment,
              icon: Icons.account_balance,
              title: '銀行振込',
              subtitle: '振込手数料はお客様負担となります',
              onTap: () => setState(() => _payment = 1),
            ),
            if (_payment == 0) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppTheme.outlineVariant.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(children: [
                  Row(children: [
                    const Icon(Icons.lock_outline, size: 16),
                    const SizedBox(width: 8),
                    Text('カード情報を入力',
                        style: GoogleFonts.notoSansJp(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ]),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'カード番号',
                      hintStyle: GoogleFonts.notoSansJp(
                          fontSize: 14, color: AppTheme.onSurfaceVariant),
                      filled: true,
                      fillColor: AppTheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '有効期限 (MM/YY)',
                          hintStyle: GoogleFonts.notoSansJp(
                              fontSize: 12, color: AppTheme.onSurfaceVariant),
                          filled: true,
                          fillColor: AppTheme.surfaceContainerLow,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'CVV',
                          hintStyle: GoogleFonts.notoSansJp(
                              fontSize: 12, color: AppTheme.onSurfaceVariant),
                          filled: true,
                          fillColor: AppTheme.surfaceContainerLow,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ]),
              ),
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border(
              top: BorderSide(color: AppTheme.outlineVariant.withOpacity(0.3))),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Price breakdown
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(children: [
              _PriceRow(label: '宿泊費 (3泊)', value: '¥124,500'),
              const SizedBox(height: 8),
              _PriceRow(label: '清掃費', value: '¥8,000'),
              const SizedBox(height: 8),
              _PriceRow(label: 'サービス料', value: '¥15,200'),
              const Divider(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('合計（税込）',
                      style: GoogleFonts.notoSansJp(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                  Text('¥147,700',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.primary)),
                ],
              ),
            ]),
          ),
          SizedBox(
            width: double.infinity,
            child: Consumer<ZenState>(
              builder: (context, state, _) => ElevatedButton(
                onPressed: () {
                  state.addReservation({
                    'id': 'mp_${DateTime.now().millisecondsSinceEpoch}',
                    'type': 'minpaku',
                    'name': p?.name ?? '軽井沢の静寂に包まれるモダン和風邸宅',
                    'price': '¥147,700', // Mock total price
                    'date': '2024-11-15T00:00:00.000',
                    'image': p?.image ?? Imgs.mpDetail,
                    'details': '2024年11月15日 - 11月18日 / 2名',
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
                child: Text('予約を確定する',
                    style: GoogleFonts.notoSansJp(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '「予約を確定する」をクリックすることで、ZenLivingの利用規約およびキャンセルポリシーに同意したものとみなされます。',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansJp(
                fontSize: 9, color: AppTheme.onSurfaceVariant),
          ),
        ]),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String hint;
  const _FormField({required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: GoogleFonts.notoSansJp(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppTheme.onSurfaceVariant)),
      const SizedBox(height: 6),
      TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.notoSansJp(
              fontSize: 14, color: AppTheme.onSurfaceVariant),
          filled: true,
          fillColor: AppTheme.surfaceContainerLow,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    ]);
  }
}

class _PaymentOption extends StatelessWidget {
  final int index;
  final int selected;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _PaymentOption({
    required this.index,
    required this.selected,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selected;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.surfaceContainerLowest
              : AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppTheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(children: [
          Icon(icon,
              color: isSelected ? AppTheme.primary : AppTheme.onSurfaceVariant),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,
                  style: GoogleFonts.notoSansJp(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: GoogleFonts.notoSansJp(
                      fontSize: 11, color: AppTheme.onSurfaceVariant)),
            ]),
          ),
          Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppTheme.primary : AppTheme.onSurfaceVariant,
            ),
        ]),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.notoSansJp(
                fontSize: 12, color: AppTheme.onSurfaceVariant)),
        Text(value,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
