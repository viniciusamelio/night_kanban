import 'package:flutter/material.dart';
import 'package:night_kanban/modules/boards/pages/board-page.dart';
import 'package:night_kanban/modules/home/widgets/menu-item.dart';
import 'package:night_kanban/shared/services/navigator/navigator.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 15),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/Logo.png',
                scale: 1.3,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
              ),
              MenuItem(
                icon: Icon(Icons.pause_presentation),
                label: "Boards",
                onTap: () => pushNamed(routeName: BoardPage.route),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              MenuItem(
                icon: Icon(Icons.logout),
                label: "Sair",
                onTap: () => pushNamed(routeName: BoardPage.route),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
