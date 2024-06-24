import 'package:flutter/material.dart';
import 'package:workmai/src/drawer/end_drawer_header.dart';
import 'package:workmai/src/drawer/end_drawer_listtile_widget.dart';

class EndDrawerStl extends StatelessWidget {
  const EndDrawerStl({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width < 700
        ? 280
        : MediaQuery.sizeOf(context).width * 0.4;
    // print('${MediaQuery.sizeOf(context).width}: $width');
    return Drawer(
      backgroundColor: Colors.white.withOpacity(0.65),
      width: width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Column(
        children: [
          const EndDrawerHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 12,
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffd0ffed),
                    ),
                    child: const EndDrawerListTileWidget(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
