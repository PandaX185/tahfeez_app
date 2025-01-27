import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_controller.dart';
import '../config/theme.dart';
import '../config/theme_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginControllerProvider);
    final loginController = ref.read(loginControllerProvider.notifier);
    final isDarkMode = ref.watch(themeControllerProvider);

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              ref.read(themeControllerProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 600,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: screenSize.height * 0.02,
                children: [
                  Image.asset(
                    'assets/images/quran.png',
                    width: min(screenSize.width * 0.35, 200),
                    height: min(screenSize.width * 0.35, 200),
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: loginController.updateEmail,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.emailHint,
                      labelText: AppLocalizations.of(context)!.emailLabel,
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  TextField(
                    onChanged: loginController.updatePassword,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.passwordHint,
                      labelText: AppLocalizations.of(context)!.passwordLabel,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: loginController.togglePasswordVisibility,
                        icon: Icon(
                          loginState.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: !loginState.isPasswordVisible,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      screenSize.width > 600
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: _buildLoginButtons(
                                context,
                                loginState,
                                loginController,
                              ),
                            )
                          : Column(
                              children: [
                                ..._buildLoginButtons(
                                  context,
                                  loginState,
                                  loginController,
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),
                        child: Text(
                            AppLocalizations.of(context)!.createNewAccount),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLoginButtons(
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
                await loginController.loginAsTeacher();
                if (context.mounted) {
                  Navigator.pushNamed(context, '/home');
                }
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
                await loginController.loginAsStudent();
                if (context.mounted) {
                  Navigator.pushNamed(context, '/student');
                }
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
}
