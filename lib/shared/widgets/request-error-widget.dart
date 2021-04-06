import 'package:flutter/material.dart';
import 'package:night_kanban/shared/styles/colors.dart';

class RequestErrorFeedback extends StatelessWidget {
  const RequestErrorFeedback({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: darkGrey.withOpacity(0.95),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/error.png',
              scale: 3.7,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Opa!!",
              style: TextStyle(
                  color: Colors.red, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Algo deu errado com sua requisição...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
