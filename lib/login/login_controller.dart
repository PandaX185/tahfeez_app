import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tahfeez_app/api/api_client.dart';
import 'package:tahfeez_app/models/login/login_models.dart';
import 'package:flutter/material.dart';
import 'package:tahfeez_app/models/login/teacher/teacher_models.dart';
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

      state = state.copyWith(
        isTeacherLoading: false,
        token: response.token,
      );
      if (context.mounted) {
        Navigator.pushNamed(context, '/home', arguments: state.token);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                e is DioException ? e.response?.data['message'] : e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      state = state.copyWith(isTeacherLoading: false);
    }
  }

  Future<List<TeacherResponse>> getTeachersList() async {
    final response = await apiClient.getTeachersList();
    return response;
  }

  Future<void> loginAsStudent(
      BuildContext context, TeacherResponse selectedTeacher) async {
    state = state.copyWith(isStudentLoading: true);
    try {
      final response = await apiClient.loginAsStudent(
          LoginAsStudentRequest(
            phone: state.phone.toString(),
            password: state.password.toString(),
          ),
          selectedTeacher.id.toString());

      state = state.copyWith(
        isStudentLoading: false,
        token: response.token,
      );
      if (context.mounted) {
        Navigator.pushNamed(context, '/home', arguments: state.token);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                e is DioException ? e.response?.data['message'] : e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
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
