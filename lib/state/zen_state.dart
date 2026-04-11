import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppMode { realEstate, minpaku }

class ZenState extends ChangeNotifier {
  AppMode _mode = AppMode.realEstate;
  final Set<String> _favorites = {};
  final List<Map<String, dynamic>> _reservations = [];
  int _tabIndex = 0;
  String? _toastMessage;
  Timer? _toastTimer;
  bool _isInitialized = false;
  Locale _locale = const Locale('ja');

  AppMode get mode => _mode;
  Set<String> get favorites => Set.unmodifiable(_favorites);
  List<Map<String, dynamic>> get reservations =>
      List.unmodifiable(_reservations);
  int get tabIndex => _tabIndex;
  String? get toastMessage => _toastMessage;
  bool get isInitialized => _isInitialized;
  Locale get locale => _locale;

  ZenState() {
    _initStore();
  }

  Future<void> _initStore() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load favorites
    try {
      final favList = prefs.getStringList('zen_favorites') ?? [];
      _favorites.addAll(favList);
    } catch (_) {}

    // Load reservations
    try {
      final resJson = prefs.getString('zen_reservations');
      if (resJson != null) {
        final List<dynamic> decoded = jsonDecode(resJson);
        _reservations.addAll(decoded.cast<Map<String, dynamic>>());
      }
    } catch (_) {}

    // Load mode
    final savedMode = prefs.getString('zen_mode');
    if (savedMode == 'minpaku') {
      _mode = AppMode.minpaku;
    }

    final savedLocale = prefs.getString('zen_locale');
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
    }

    _isInitialized = true;
    notifyListeners();
  }

  void setMode(AppMode mode) {
    _mode = mode;
    _tabIndex = 0;
    _saveToPrefs();
    notifyListeners();
  }

  void setTabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }

  void setLocale(String languageCode) {
    _locale = Locale(languageCode);
    _saveToPrefs();
    notifyListeners();
  }

  bool isFavorite(String id) => _favorites.contains(id);

  void toggleFavorite(String id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
      _showToast('お気に入りから削除しました');
    } else {
      _favorites.add(id);
      _showToast('お気に入りに追加しました');
    }
    _saveToPrefs();
    notifyListeners();
  }

  void addReservation(Map<String, dynamic> details) {
    _reservations.insert(0, details); // Newest first
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('zen_favorites', _favorites.toList());
    await prefs.setString('zen_reservations', jsonEncode(_reservations));
    await prefs.setString('zen_mode', _mode == AppMode.minpaku ? 'minpaku' : 'realEstate');
    await prefs.setString('zen_locale', _locale.languageCode);
  }

  void _showToast(String message) {
    _toastMessage = message;
    notifyListeners();
    _toastTimer?.cancel();
    _toastTimer = Timer(const Duration(seconds: 3), () {
      _toastMessage = null;
      notifyListeners();
    });
  }
}
