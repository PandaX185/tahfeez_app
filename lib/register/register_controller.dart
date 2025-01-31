import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tahfeez_app/api/api_client.dart';
import 'package:tahfeez_app/dto/login/teacher/teacher_models.dart';
import 'package:tahfeez_app/dto/register/register_models.dart';
import 'package:tahfeez_app/components/shared_snackbars.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  final ApiClient apiClient = ApiClient(Dio());

  @override
  RegisterState build() {
    return const RegisterState();
  }

  Future<List<TeacherSelectionResponse>> fetchTeachersList() async {
    final response = await apiClient.fetchTeachersList();
    return response;
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  void updateLevel(String level) {
    state = state.copyWith(level: level);
  }

  void updateGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void updateBirthDate(String birthDate) {
    state = state.copyWith(birthDate: birthDate);
  }

  void updateTeacherId(String teacherId) {
    state = state.copyWith(teacherId: teacherId);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible);
  }

  Future<void> register(BuildContext context,
      {required String name,
      required String phone,
      required String password,
      required String level,
      required String gender,
      required String birthDate,
      required String teacherId}) async {
    state = state.copyWith(isLoading: true);

    try {
      await apiClient.register(
        RegisterRequest(
          name: state.name,
          phone: state.phone,
          password: state.password,
          level: state.level,
          gender: state.gender,
          birthDate: state.birthDate,
        ),
        state.teacherId,
      );
      state = state.copyWith(isLoading: false);

      if (context.mounted) {
        successSnackBar(context, 'تم التسجيل بنجاح');
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        errorSnackBar(context, e.toString());
      }
    }
  }
}

class RegisterState {
  final bool isLoading, isPasswordVisible, isConfirmPasswordVisible;
  final String name,
      phone,
      password,
      confirmPassword,
      level,
      gender,
      birthDate,
      teacherId;

  const RegisterState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.name = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.level = '',
    this.gender = '',
    this.birthDate = '',
    this.teacherId = '',
  });

  RegisterState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? name,
    String? phone,
    String? password,
    String? confirmPassword,
    String? level,
    String? gender,
    String? birthDate,
    String? teacherId,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      level: level ?? this.level,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      teacherId: teacherId ?? this.teacherId,
    );
  }
}
