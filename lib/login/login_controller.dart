import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tahfeez_app/api/api_client.dart';
import 'package:tahfeez_app/models/login_models.dart';
import 'package:flutter/material.dart';
part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  final ApiClient apiClient = ApiClient(Dio());

  @override
  LoginState build() {
    return const LoginState();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> loginAsTeacher(BuildContext context) async {
    state = state.copyWith(isTeacherLoading: true);
    try {
      final response = await apiClient.loginAsTeacher(LoginAsTeacherRequest(
        phone: state.phone.toString(),
        password: state.password.toString(),
      ));
      if (response.token.isNotEmpty) {
        state = state.copyWith(
          isTeacherLoading: false,
          token: response.token,
        );
        if (context.mounted) {
          Navigator.pushNamed(context, '/home');
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid login credentials'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e is DioException
                ? '${e.response?.data['message']}'
                : 'An error occurred during login ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      state = state.copyWith(isTeacherLoading: false);
    }
  }

  Future<void> loginAsStudent() async {
    state = state.copyWith(isStudentLoading: true);
    try {
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      state = state.copyWith(isStudentLoading: false);
    }
  }
}

class LoginState {
  final String phone;
  final String password;
  final String token;
  final bool isPasswordVisible;
  final bool isStudentLoading;
  final bool isTeacherLoading;

  const LoginState({
    this.phone = '',
    this.password = '',
    this.token = '',
    this.isPasswordVisible = false,
    this.isStudentLoading = false,
    this.isTeacherLoading = false,
  });

  LoginState copyWith({
    String? phone,
    String? password,
    String? token,
    bool? isPasswordVisible,
    bool? isStudentLoading,
    bool? isTeacherLoading,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      token: token ?? this.token,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isStudentLoading: isStudentLoading ?? this.isStudentLoading,
      isTeacherLoading: isTeacherLoading ?? this.isTeacherLoading,
    );
  }
}
