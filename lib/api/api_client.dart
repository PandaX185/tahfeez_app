import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:tahfeez_app/models/home/profile_models.dart';
import 'package:tahfeez_app/models/login/teacher/teacher_models.dart';
import '../config/app_config.dart';
import '../models/login/login_models.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppConfig.apiBaseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/teacher/login')
  Future<LoginResponse> loginAsTeacher(@Body() LoginAsTeacherRequest request);

  @POST('/student/login')
  Future<LoginResponse> loginAsStudent(@Body() LoginAsStudentRequest request,
      @Query('teacherId') String teacherId);

  @GET('/teacher')
  Future<List<TeacherSelectionResponse>> getTeachersList(
      @Query('studentPhone') String phone);

  @GET('/teacher/current')
  Future<ProfileResponse> getTeacherProfile();

  @GET('/student/current')
  Future<ProfileResponse> getStudentProfile();
}
