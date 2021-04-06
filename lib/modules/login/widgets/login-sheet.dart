import 'package:fbutton/fbutton.dart';
import 'package:flutter/material.dart';
import 'package:night_kanban/modules/home/pages/home-page.dart';
import 'package:night_kanban/modules/login/controller/login-controller.dart';
import 'package:night_kanban/modules/login/repository/login-repository.dart';
import 'package:night_kanban/shared/dto/user-dto.dart';
import 'package:night_kanban/shared/entities/user.dart';
import 'package:night_kanban/shared/services/dialogs/awesome-dialog-service.dart';
import 'package:night_kanban/shared/services/dialogs/dto/dialog-dto.dart';
import 'package:night_kanban/shared/services/http_client/custom-dio.dart';
import 'package:night_kanban/shared/services/navigator/navigator.dart';
import 'package:night_kanban/shared/services/storage/hive-service.dart';
import 'package:night_kanban/shared/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:rx_notifier/rx_notifier.dart';

class LoginSheet extends StatefulWidget {
  @override
  _LoginSheetState createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet> {
  User user;
  LoginController _loginController;
  RxDisposer _loginDisposer;
  RxDisposer _checkUserDisposer;
  GlobalKey<FormState> _loginFormKey;

  @override
  void initState() {
    _loginFormKey = GlobalKey<FormState>();
    _loginController = LoginController(
        LoginRepository(
          HttpClient(),
        ),
        HiveService());
    _loginDisposer = rxObserver(
      () => _loginController.loginRequest.status,
      filter: () =>
          _loginController.loginRequest.status != FutureStatus.pending,
      effect: (FutureStatus status) async {
        final data = _loginController.loginRequest.data;
        if (status == FutureStatus.rejected && data != null) {
          final error = _loginController.loginRequest.error;
          final message = error[0].response.data['message'];
          return AwesomeDialogService().errorDialog(DialogDto(
              message: message, context: context, showCloseIcon: true));
        }
        if (status == FutureStatus.fulfilled && data != null) {
          user.data = data;
          _loginController.saveUser(data);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomePage.route, (route) => false);
        }
      },
    );

    _checkUserDisposer = rxObserver(
        () => _loginController.checkLoginRequest.status,
        filter: () =>
            _loginController.checkLoginRequest.data != null &&
            _loginController.checkLoginRequest.status == FutureStatus.fulfilled,
        effect: (_) {
          user.data = UserDto.fromJson(_loginController.checkLoginRequest.data);
          pushNamedAndRemoveUntill(routeName: '/home');
        });
    super.initState();
  }

  @override
  void dispose() {
    _loginDisposer();
    _checkUserDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Positioned(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: purpleGradientSecondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              topRight: Radius.circular(100),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/Logo.png',
                          scale: 0.9,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        onSaved: (e) {
                          _loginController.authDto.email = e;
                        },
                        decoration: InputDecoration(
                          labelText: "Usuário",
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Icon(
                              Icons.remove_red_eye_rounded,
                              color: lightPurple,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: lightPurple,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        onSaved: (e) {
                          _loginController.authDto.password = e;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: lightPurple,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: FButton(
                            color: darkGrey,
                            onPressed: _validateForm,
                            cornerStyle: FCornerStyle.round,
                            corner: FCorner.all(8),
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 34,
                            ),
                            image: RxBuilder(
                              builder: (_) {
                                final status =
                                    _loginController.loginRequest.status;

                                if (status == FutureStatus.pending) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Icon(
                                  Icons.chevron_right_rounded,
                                  color: lightPurple,
                                  size: 45,
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  elevation: 0,
                  highlightElevation: 0,
                  hoverElevation: 0,
                  color: darkPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 40,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Criar conta",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 2)
            ],
          ),
        ),
        bottom: 0,
        left: 0);
  }

  _validateForm() {
    FocusScope.of(context).unfocus();
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();
      _loginController.submitAction();
    }
  }
}
