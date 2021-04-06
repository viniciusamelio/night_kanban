import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Function onTap;
  final Icon icon;
  final String label;

  const MenuItem(
      {Key key,
      @required this.onTap,
      @required this.icon,
      @required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 8,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
