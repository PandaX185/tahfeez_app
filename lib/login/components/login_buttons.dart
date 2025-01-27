import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tahfeez_app/login/components/teacher_selection.dart';
import 'package:tahfeez_app/login/login_controller.dart';
import 'package:tahfeez_app/config/theme.dart';

List<Widget> buildLoginButtons(
  BuildContext context,
  LoginState loginState,
  LoginController loginController,
) {
  final screenSize = MediaQuery.of(context).size;
  final brightness = Theme.of(context).brightness;
  final isDarkMode = brightness == Brightness.dark;

  return [
    ElevatedButton(
      onPressed: loginState.isTeacherLoading
          ? null
          : () async {
              await loginController.loginAsTeacher(context);
            },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: min(screenSize.width * 0.08, 50),
          vertical: screenSize.height * 0.02,
        ),
      ),
      child: loginState.isTeacherLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(AppLocalizations.of(context)!.loginAsTeacher),
    ),
    if (screenSize.width <= 600) const SizedBox(height: 16),
    ElevatedButton(
      onPressed: loginState.isStudentLoading
          ? null
          : () async {
              await showTeacherSelectionDialog(context, loginController);
            },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isDarkMode ? AppTheme.secondaryDark : AppTheme.secondaryLight,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: min(screenSize.width * 0.08, 50),
          vertical: screenSize.height * 0.02,
        ),
      ),
      child: loginState.isStudentLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(AppLocalizations.of(context)!.loginAsStudent),
    ),
  ];
}
