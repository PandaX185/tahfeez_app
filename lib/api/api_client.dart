import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:tahfeez_app/dto/home/profile_models.dart';
import 'package:tahfeez_app/dto/login/teacher/teacher_models.dart';
import 'package:tahfeez_app/dto/register/register_models.dart';
import '../config/app_config.dart';
import '../dto/login/login_models.dart';

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
  Future<List<TeacherSelectionResponse>> fetchTeachersByStudentPhone(
      @Query('studentPhone') String phone);

  @GET('/teacher')
  Future<List<TeacherSelectionResponse>> fetchTeachersList();

  @GET('/teacher/current')
  Future<ProfileResponse> getTeacherProfile();

  @GET('/student/current')
  Future<ProfileResponse> getStudentProfile();

  @POST('/student')
  Future<RegisterResponse> register(
      @Body() RegisterRequest request, @Query('teacherId') String teacherId);
}
