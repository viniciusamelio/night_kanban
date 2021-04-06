import 'package:night_kanban/modules/login/dto/auth-dto.dart';
import 'package:night_kanban/modules/login/interfaces/ilogin-repository.dart';
import 'package:night_kanban/shared/dto/user-dto.dart';
import 'package:night_kanban/shared/services/storage/interfaces/storage-adapter.dart';
import 'package:rx_notifier/rx_notifier.dart';

class LoginController {
  final InterfaceLoginRepository _loginRepository;
  final StorageAdapter _storage;
  LoginController(this._loginRepository, this._storage) {
    _checkUser();
  }

  AuthDto authDto = AuthDto();

  RxFuture<UserDto> loginRequest = RxFuture.of(Future.value(null).asRx());
  RxFuture checkLoginRequest = RxFuture.of(Future.value(null).asRx());

  submitAction() {
    loginRequest.value = _loginRepository.auth(authDto).asRx();
  }

  _checkUser() async {
    checkLoginRequest.value = _storage.read('user').asRx();
  }

  saveUser(UserDto user) {
    _storage.store('user', user.toJson());
  }
}
