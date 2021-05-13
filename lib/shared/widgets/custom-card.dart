import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:night_kanban/shared/styles/colors.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final Function onTap;
  final Widget footer;

  const CustomCard(
      {Key key, this.title, this.description, this.onTap, this.footer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: secondaryGrey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: lightGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.more_vert,
                  size: 30,
                  color: Color.fromRGBO(99, 97, 227, 1),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              description ?? '',
              textAlign: TextAlign.left,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color.fromRGBO(102, 102, 102, 1),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            footer ?? Container()
          ],
        ),
      ),
    );
  }
}
