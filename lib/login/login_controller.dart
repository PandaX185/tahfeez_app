import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tahfeez_app/api/api_client.dart';
import 'package:tahfeez_app/dto/login/login_models.dart';
import 'package:flutter/material.dart';
import 'package:tahfeez_app/dto/login/teacher/teacher_models.dart';
part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  ApiClient apiClient = ApiClient(Dio());

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
        token: response.token.toString(),
      );
      if (context.mounted) {
        Navigator.pushNamed(context, '/home', arguments: state.token);
      }

      final dio = Dio();
      dio.options.headers['Authorization'] =
          'Bearer ${response.token.toString()}';
      apiClient = ApiClient(dio);

      final profileResponse = await apiClient.getTeacherProfile();

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('token', response.token.toString());
      await prefs.setString('role', 'teacher');
      await prefs.setString('id', profileResponse.id.toString());
      await prefs.setString('name', profileResponse.name.toString());
      await prefs.setString('phone', profileResponse.phone.toString());
      await prefs.setString('birthDate', profileResponse.birthDate.toString());
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

  Future<List<TeacherSelectionResponse>> getTeachersList(String phone) async {
    final response = await apiClient.fetchTeachersByStudentPhone(phone);
    return response;
  }

  Future<void> loginAsStudent(
      BuildContext context, TeacherSelectionResponse selectedTeacher) async {
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
        token: response.token.toString(),
      );

      final dio = Dio();
      dio.options.headers['Authorization'] =
          'Bearer ${response.token.toString()}';
      apiClient = ApiClient(dio);

      final profileResponse = await apiClient.getStudentProfile();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token.toString());
      await prefs.setString('role', 'student');
      await prefs.setString('id', profileResponse.id.toString());
      await prefs.setString('teacherId', selectedTeacher.id.toString());
      await prefs.setString('name', profileResponse.name.toString());
      await prefs.setString('phone', profileResponse.phone.toString());
      await prefs.setString('birthDate', profileResponse.birthDate.toString());
      await prefs.setInt('level', profileResponse.level ?? 0);

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
