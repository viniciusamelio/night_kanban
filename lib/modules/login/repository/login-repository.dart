import 'package:night_kanban/modules/login/dto/auth-dto.dart';
import 'package:night_kanban/modules/login/interfaces/ilogin-repository.dart';
import 'package:night_kanban/shared/dto/user-dto.dart';
import 'package:night_kanban/shared/services/http_client/custom-dio.dart';

class LoginRepository implements InterfaceLoginRepository {
  final HttpClient _http;

  LoginRepository(this._http);

  Future<UserDto> auth(AuthDto authDto) async {
    try {
      final result = await _http.post('/auth', data: authDto.toJson());
      return UserDto.fromJson(result.data['user']);
    } catch (e) {
      throw e;
    }
  }
}
