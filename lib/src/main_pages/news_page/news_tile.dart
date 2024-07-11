import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xffEFFED5),
          borderRadius: BorderRadius.circular(52.0),
        ),
        child: Row(
          children: [
            Container(
              child: Column(

              )
            ),

          ],
        ),
      ),
    );
  }
}
