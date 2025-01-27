import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  LoginState build() {
    return const LoginState();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> loginAsTeacher() async {
    state = state.copyWith(isTeacherLoading: true);
    try {
      await Future.delayed(const Duration(seconds: 2));
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
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isStudentLoading;
  final bool isTeacherLoading;
  
  const LoginState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isStudentLoading = false,
    this.isTeacherLoading = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isStudentLoading,
    bool? isTeacherLoading,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isStudentLoading: isStudentLoading ?? this.isStudentLoading,
      isTeacherLoading: isTeacherLoading ?? this.isTeacherLoading,
    );
  }
} 