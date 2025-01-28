import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tahfeez_app/components/app_bar.dart';
import 'package:tahfeez_app/login/components/login_buttons.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SharedAppBar(
          title: AppLocalizations.of(context)!.appName,
        ),
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
                    onChanged: loginController.updatePhone,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.phoneHint,
                      labelText: AppLocalizations.of(context)!.phoneLabel,
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
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
                              children: buildLoginButtons(
                                context,
                                loginState,
                                loginController,
                              ),
                            )
                          : Column(
                              children: [
                                ...buildLoginButtons(
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
}
