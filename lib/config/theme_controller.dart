import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeControllerProvider = StateNotifierProvider<ThemeController, bool>(
  (ref) => ThemeController(),
);

class ThemeController extends StateNotifier<bool> {
  ThemeController() : super(WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);

  void toggleTheme() {
    state = !state;
  }
} 