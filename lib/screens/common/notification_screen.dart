import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'type': 'system',
        'title': 'メンテナンスのお知らせ',
        'date': '2023.11.10',
        'content': '11月15日(水) 02:00〜05:00の間、システムメンテナンスのためサービスを一時停止いたします。',
      },
      {
        'type': 'reservation',
        'title': '予約確定のお知らせ',
        'date': '2023.11.08',
        'content': '「鎌倉 隠れ家ヴィラ」の予約が確定しました。詳細は予約管理画面をご確認ください。',
      },
      {
        'type': 'campaign',
        'title': '冬の早期予約キャンペーン開始',
        'date': '2023.11.05',
        'content': '12月〜1月の宿泊が今なら20%OFF！期間限定のキャンペーンをお見逃しなく。',
      },
      {
        'type': 'info',
        'title': 'プライバシーポリシー改定のお知らせ',
        'date': '2023.11.01',
        'content': 'サービスの向上に伴い、プライバシーポリシーの一部を改定いたしました。',
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('お知らせ',
            style: GoogleFonts.notoSansJp(
                fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.onSurface)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => Divider(
            height: 1, color: AppTheme.outlineVariant.withOpacity(0.3)),
        itemBuilder: (_, i) {
          final n = notifications[i];
          return _NotificationTile(
            type: n['type']!,
            title: n['title']!,
            date: n['date']!,
            content: n['content']!,
          );
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String type;
  final String title;
  final String date;
  final String content;

  const _NotificationTile({
    required this.type,
    required this.title,
    required this.date,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    switch (type) {
      case 'system':
        icon = Icons.settings_suggest;
        color = AppTheme.error;
        break;
      case 'reservation':
        icon = Icons.event_available;
        color = AppTheme.primary;
        break;
      case 'campaign':
        icon = Icons.campaign;
        color = AppTheme.secondary;
        break;
      default:
        icon = Icons.info_outline;
        color = AppTheme.outline;
    }

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(title,
                            style: GoogleFonts.notoSansJp(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Text(date,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 10, color: AppTheme.onSurfaceVariant)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(content,
                      style: GoogleFonts.notoSansJp(
                          fontSize: 12,
                          color: AppTheme.onSurfaceVariant,
                          height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
