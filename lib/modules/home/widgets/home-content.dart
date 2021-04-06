import 'package:flutter/material.dart';
import 'package:night_kanban/shared/entities/user.dart';
import 'package:night_kanban/shared/styles/colors.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: darkGrey,
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width / 3,
            top: MediaQuery.of(context).size.height / 2 - 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Bem vindo,",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 30,
                  ),
                ),
                Text(
                  user.data.name.split(' ')[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkPurple,
                    fontSize: 37,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/City-BG.png',
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
