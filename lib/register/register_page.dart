import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tahfeez_app/components/shared_app_bar.dart';
import 'package:tahfeez_app/config/theme.dart';
import 'package:tahfeez_app/config/theme_controller.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isDarkMode = ref.watch(themeControllerProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: SharedAppBar(
          title: AppLocalizations.of(context)!.register,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: screenSize.height * 0.03,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.nameHint,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.phoneHint,
                labelText: AppLocalizations.of(context)!.phoneLabel,
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.passwordHint,
                labelText: AppLocalizations.of(context)!.passwordLabel,
                prefixIcon: const Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.confirmPasswordHint,
                labelText: AppLocalizations.of(context)!.confirmPasswordLabel,
                prefixIcon: const Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenSize.width * 0.6,
                  child: DropdownMenu(
                    width: double.infinity,
                    menuStyle: MenuStyle(
                      backgroundColor: WidgetStateColor.resolveWith(
                        (states) => isDarkMode
                            ? AppTheme.darkTheme.colorScheme.surface
                            : AppTheme.lightTheme.colorScheme.surface,
                      ),
                    ),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: '1', label: '1'),
                      DropdownMenuEntry(value: '2', label: '2'),
                      DropdownMenuEntry(value: '3', label: '3'),
                      DropdownMenuEntry(value: '4', label: '4'),
                      DropdownMenuEntry(value: '5', label: '5'),
                      DropdownMenuEntry(value: '6', label: '6'),
                      DropdownMenuEntry(value: '7', label: '7'),
                      DropdownMenuEntry(value: '8', label: '8'),
                      DropdownMenuEntry(value: '9', label: '9'),
                      DropdownMenuEntry(value: '10', label: '10'),
                    ],
                    label: Text(AppLocalizations.of(context)!.levelLabel),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.3,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(AppLocalizations.of(context)!.male),
                          leading: Radio(
                            value: AppLocalizations.of(context)!.male,
                            groupValue: AppLocalizations.of(context)!.male,
                            onChanged: (value) => {},
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(AppLocalizations.of(context)!.female),
                          leading: Radio(
                            value: AppLocalizations.of(context)!.female,
                            groupValue: AppLocalizations.of(context)!.male,
                            onChanged: (value) => {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InputDatePickerFormField(
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              fieldLabelText: AppLocalizations.of(context)!.birthdateLabel,
              onDateSubmitted: (date) {},
              errorFormatText: AppLocalizations.of(context)!.invalidDateFormat,
              errorInvalidText: AppLocalizations.of(context)!.invalidDate,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: Size(screenSize.width * 1, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: min(screenSize.width * 0.08, 50),
                  vertical: screenSize.height * 0.03,
                ),
              ),
              child: Text(AppLocalizations.of(context)!.register),
            )
          ],
        ),
      ),
    );
  }
}
