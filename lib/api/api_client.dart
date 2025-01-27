import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../models/login_models.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppConfig.apiBaseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/teacher/login')
  Future<LoginResponse> loginAsTeacher(@Body() LoginAsTeacherRequest request);

  @POST('/student/login')
  Future<LoginResponse> loginAsStudent(@Body() LoginAsStudentRequest request);
}
