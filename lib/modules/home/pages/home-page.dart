import 'package:animated_drawer/views/animated_drawer.dart';
import 'package:flutter/material.dart';
import 'package:night_kanban/modules/home/widgets/drawer.dart';
import 'package:night_kanban/modules/home/widgets/home-content.dart';
import 'package:night_kanban/shared/styles/colors.dart';

class HomePage extends StatelessWidget {
  static String route = "/home";
  @override
  Widget build(BuildContext context) {
    return AnimatedDrawer(
        homePageXValue: 230,
        homePageYValue: 120,
        homePageAngle: -0.2,
        homePageSpeed: 200,
        shadowXValue: 100,
        shadowYValue: 110,
        shadowAngle: -0.333,
        shadowSpeed: 430,
        openIcon: Icon(
          Icons.menu_open,
          color: Colors.white54,
          size: 40,
        ),
        closeIcon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white60,
          size: 35,
        ),
        shadowColor: darkPurple,
        backgroundGradient: purpleGradientSecondary,
        menuPageContent: MenuPage(),
        homePageContent: HomeContent());
  }
}
