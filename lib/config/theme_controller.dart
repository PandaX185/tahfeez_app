import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeControllerProvider = StateNotifierProvider<ThemeController, bool>(
  (ref) => ThemeController(),
);

class ThemeController extends StateNotifier<bool> {
  ThemeController() : super(false) {
    _loadTheme();
  }

  Future<void> toggleTheme() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', state);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('theme') ??
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
  }
}
