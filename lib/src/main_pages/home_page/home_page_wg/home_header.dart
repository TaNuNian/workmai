import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'WorkMai',
          style: GoogleFonts.raleway(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            // Inbox
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inbox');
              },
              icon: const Icon(
                Icons.inbox,
                size: 36,
              ),
            ),

            // End-Drawer
            IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(
                Icons.menu,
                size: 36,
              ),
            ),
          ],
        )
      ],
    )
    ;
  }
}
