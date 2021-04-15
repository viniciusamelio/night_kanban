import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:night_kanban/modules/boards/pages/board-add-page.dart';
import 'package:night_kanban/modules/boards/pages/board-page.dart';
import 'package:night_kanban/modules/home/pages/home-page.dart';
import 'package:night_kanban/shared/entities/user.dart';
import 'package:night_kanban/shared/styles/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'modules/login/pages/login-page.dart';
import 'shared/services/navigator/navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initStorage();
  runApp(MyApp());
}

_initStorage() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  return await Hive.openBox('mybox');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<User>(create: (_) => User())],
      child: MaterialApp(
        title: 'Night Kanban',
        navigatorKey: navigationKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: GoogleFonts.raleway().fontFamily,
          brightness: Brightness.dark,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.grey.withAlpha(150),
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            prefixStyle: TextStyle(color: lightPurple),
            focusColor: Colors.deepPurpleAccent,
            fillColor: darkGrey,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: darkGrey),
              borderRadius: BorderRadius.circular(50),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: darkPurple,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(50)),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: darkGrey),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        builder: (context, widget) => ResponsiveWrapper.builder(widget,
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(480, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
            background: Container(color: Color(0xFFF5F5F5))),
        initialRoute: "/",
        routes: {
          '/': (context) => LoginPage(),
          LoginPage.route: (context) => LoginPage(),
          HomePage.route: (context) => HomePage(),
          BoardPage.route: (context) => BoardPage(),
          BoardAddPage.route: (context) => BoardAddPage()
        },
      ),
    );
  }
}
