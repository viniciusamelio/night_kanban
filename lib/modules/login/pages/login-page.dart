import 'package:flutter/material.dart';
import 'package:night_kanban/modules/login/widgets/login-sheet.dart';
import 'package:night_kanban/shared/styles/colors.dart';

class LoginPage extends StatelessWidget {
  static String route = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: darkGrey,
                  image: DecorationImage(
                      image: AssetImage('assets/Night-BG.png'),
                      fit: BoxFit.cover)),
            ),
            LoginSheet()
          ],
        ),
      ),
    );
  }
}
