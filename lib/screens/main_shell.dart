import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../state/zen_state.dart';
import '../theme/app_theme.dart';
import 'real_estate/re_home_screen.dart';
import 'real_estate/re_search_screen.dart';
import 'real_estate/re_favorites_screen.dart';
import 'real_estate/re_mypage_screen.dart';
import 'minpaku/mp_home_screen.dart';
import 'minpaku/mp_search_screen.dart';
import 'minpaku/mp_favorites_screen.dart';
import 'minpaku/mp_reservations_screen.dart';
import 'minpaku/mp_mypage_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ZenState>();
    final isMinpaku = state.mode == AppMode.minpaku;

    final reScreens = const [
      ReHomeScreen(),
      ReSearchScreen(),
      ReFavoritesScreen(),
      ReMypageScreen(),
    ];

    final mpScreens = const [
      MpHomeScreen(),
      MpSearchScreen(),
      MpReservationsScreen(),
      MpFavoritesScreen(),
      MpMypageScreen(),
    ];

    final screens = isMinpaku ? mpScreens : reScreens;
    final safeIndex = state.tabIndex.clamp(0, screens.length - 1);

    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Stack(
        children: [
          IndexedStack(index: safeIndex, children: screens),
          // Toast overlay
          if (state.toastMessage != null)
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: _ZenToast(message: state.toastMessage!),
            ),
        ],
      ),
      bottomNavigationBar: _ZenBottomNav(
        isMinpaku: isMinpaku,
        currentIndex: safeIndex,
        onTap: (i) => context.read<ZenState>().setTabIndex(i),
      ),
    );
  }
}

class _ZenToast extends StatelessWidget {
  final String message;
  const _ZenToast({required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.onSurface.withOpacity(0.92),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20)
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF88D982), size: 18),
            const SizedBox(width: 10),
            Text(
              message,
              style: GoogleFonts.notoSansJp(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ZenBottomNav extends StatelessWidget {
  final bool isMinpaku;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _ZenBottomNav({
    required this.isMinpaku,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reItems = [
      BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: l10n.navHome),
      BottomNavigationBarItem(
          icon: const Icon(Icons.search), label: l10n.navSearch),
      BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_outline),
          activeIcon: const Icon(Icons.favorite),
          label: l10n.navFavorites),
      BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: l10n.navMyPage),
    ];

    final mpItems = [
      BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: l10n.navHome),
      BottomNavigationBarItem(
          icon: const Icon(Icons.search), label: l10n.navSearch),
      BottomNavigationBarItem(
          icon: const Icon(Icons.event_available_outlined),
          activeIcon: const Icon(Icons.event_available),
          label: l10n.navReservations),
      BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_outline),
          activeIcon: const Icon(Icons.favorite),
          label: l10n.navFavorites),
      BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: l10n.navMyPage),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        border: Border(
            top: BorderSide(
                color: AppTheme.outlineVariant.withOpacity(0.3), width: 0.5)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, -4)),
        ],
      ),
      child: BottomNavigationBar(
        items: isMinpaku ? mpItems : reItems,
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: const Color(0xFF9E9E9E),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            GoogleFonts.notoSansJp(fontSize: 10, fontWeight: FontWeight.bold),
        unselectedLabelStyle: GoogleFonts.notoSansJp(fontSize: 10),
      ),
    );
  }
}
