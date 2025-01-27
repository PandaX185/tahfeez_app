import 'package:flutter/material.dart';
import 'package:tahfeez_app/login/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tahfeez_app/config/theme.dart';
import 'package:tahfeez_app/config/theme_controller.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeControllerProvider);
    
    return MaterialApp(
      title: 'Tahfeez',
      theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
