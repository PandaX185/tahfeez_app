import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tahfeez_app/components/shared_app_bar.dart';
import 'package:tahfeez_app/components/shared_snackbars.dart';
import 'package:tahfeez_app/config/theme.dart';
import 'package:tahfeez_app/config/theme_controller.dart';
import 'package:tahfeez_app/dto/register/register_models.dart';
import 'package:tahfeez_app/register/components/teacher_selection.dart';
import 'package:tahfeez_app/register/register_controller.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isDarkMode = ref.watch(themeControllerProvider);
    final registerState = ref.watch(registerControllerProvider);
    final registerController = ref.read(registerControllerProvider.notifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: SharedAppBar(
          title: AppLocalizations.of(context)!.register,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: screenSize.height * 0.03,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.nameHint,
                  labelText: AppLocalizations.of(context)!.nameLabel,
                  prefixIcon: const Icon(Icons.person),
                ),
                onChanged: (value) {
                  registerController.updateName(value);
                },
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.phoneHint,
                  labelText: AppLocalizations.of(context)!.phoneLabel,
                  prefixIcon: const Icon(Icons.phone),
                ),
                onChanged: (value) {
                  registerController.updatePhone(value);
                },
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.passwordHint,
                  labelText: AppLocalizations.of(context)!.passwordLabel,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      registerController.togglePasswordVisibility();
                    },
                    icon: registerState.isPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                onChanged: (value) {
                  registerController.updatePassword(value);
                },
                obscureText: !registerState.isPasswordVisible,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.confirmPasswordHint,
                  labelText: AppLocalizations.of(context)!.confirmPasswordLabel,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      registerController.toggleConfirmPasswordVisibility();
                    },
                    icon: registerState.isConfirmPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                onChanged: (value) {
                  registerController.updateConfirmPassword(value);
                },
                obscureText: !registerState.isConfirmPasswordVisible,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.5,
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
                        DropdownMenuEntry(value: 1, label: '1'),
                        DropdownMenuEntry(value: 2, label: '2'),
                        DropdownMenuEntry(value: 3, label: '3'),
                        DropdownMenuEntry(value: 4, label: '4'),
                        DropdownMenuEntry(value: 5, label: '5'),
                        DropdownMenuEntry(value: 6, label: '6'),
                        DropdownMenuEntry(value: 7, label: '7'),
                        DropdownMenuEntry(value: 8, label: '8'),
                        DropdownMenuEntry(value: 9, label: '9'),
                        DropdownMenuEntry(value: 10, label: '10'),
                      ],
                      label: Text(AppLocalizations.of(context)!.levelLabel),
                      onSelected: (value) {
                        registerController.updateLevel(value!);
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Radio(
                        value: AppLocalizations.of(context)!.male,
                        groupValue: registerState.gender,
                        onChanged: (value) {
                          registerController.updateGender(value!);
                        },
                      ),
                      Text(AppLocalizations.of(context)!.male),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: AppLocalizations.of(context)!.female,
                        groupValue: registerState.gender,
                        onChanged: (value) {
                          registerController.updateGender(value!);
                        },
                      ),
                      Text(AppLocalizations.of(context)!.female),
                    ],
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    registerController
                        .updateBirthDate(picked.toString().split(' ')[0]);
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  registerState.birthDate.isEmpty
                      ? AppLocalizations.of(context)!.birthdateLabel
                      : registerState.birthDate.split(' ')[0],
                ),
              ),
              ElevatedButton(
                onPressed: registerState.isLoading
                    ? null
                    : () async {
                        if (registerState.password !=
                            registerState.confirmPassword) {
                          errorSnackBar(context,
                              AppLocalizations.of(context)!.passwordMismatch);
                          return;
                        }
                        await showTeacherSelectionDialog(
                          context,
                          registerController,
                          RegisterRequest(
                            name: registerState.name,
                            phone: registerState.phone,
                            password: registerState.password,
                            level: registerState.level,
                            gender: registerState.gender,
                            birthDate: registerState.birthDate,
                            teacherId: registerState.teacherId,
                          ),
                        );
                      },
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
      ),
    );
  }
}
