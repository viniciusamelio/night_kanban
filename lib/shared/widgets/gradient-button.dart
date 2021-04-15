import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final List<Color> colors;

  GradientButton({
    Key key,
    @required this.label,
    @required this.onPressed,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
            colors: colors ??
                [
                  Color.fromRGBO(80, 241, 116, 1),
                  Color.fromRGBO(9, 186, 144, 1),
                ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
