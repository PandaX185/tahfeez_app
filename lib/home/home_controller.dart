import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tahfeez_app/dto/home/profile_models.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  HomeState build() {
    getProfile();
    return HomeState();
  }

  Future<ProfileResponse> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    final name = prefs.getString('name') ?? '';
    final phone = prefs.getString('phone') ?? '';
    final birthDate = prefs.getString('birthDate') ?? '';
    final level = prefs.getInt('level') ?? 0;
    state = state.copyWith(
        profile: ProfileResponse(
      id: id,
      name: name,
      phone: phone,
      birthDate: birthDate,
      level: level,
    ));
    return ProfileResponse(
        id: id, name: name, phone: phone, birthDate: birthDate, level: level);
  }
}

class HomeState {
  final ProfileResponse profile;

  HomeState(
      {this.profile = const ProfileResponse(
        id: '',
        name: '',
        phone: '',
        birthDate: '',
        level: 0,
      )});

  HomeState copyWith({ProfileResponse? profile}) {
    return HomeState(profile: profile ?? this.profile);
  }
}
