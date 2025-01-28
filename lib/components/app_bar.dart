import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tahfeez_app/config/theme.dart';
import 'package:tahfeez_app/config/theme_controller.dart';

class SharedAppBar extends ConsumerWidget {
  final String title;
  final List<Widget>? actions;
  const SharedAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeControllerProvider);

    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor:
          isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      elevation: 0,
      actions: [
        ...actions ?? [],
      ],
    );
  }
}
