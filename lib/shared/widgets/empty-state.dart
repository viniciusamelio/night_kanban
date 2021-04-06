import 'package:flutter/material.dart';
import 'package:night_kanban/shared/styles/colors.dart';

class EmptyStateFeedback extends StatelessWidget {
  final String description;

  const EmptyStateFeedback({Key key, this.description}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: darkGrey.withOpacity(0.85),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/empty.png',
              scale: 3.7,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Nada por aqui",
              style: TextStyle(
                  color: Color.fromRGBO(39, 238, 158, 0.75),
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
