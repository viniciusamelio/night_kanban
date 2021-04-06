import 'package:night_kanban/modules/login/dto/auth-dto.dart';
import 'package:night_kanban/shared/dto/user-dto.dart';

abstract class InterfaceLoginRepository {
  Future<UserDto> auth(AuthDto dto);
}
