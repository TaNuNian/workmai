import 'package:flutter/material.dart';
import 'package:workmai/src/drawer/end_drawer_listtile.dart';

class EndDrawerListTileWidget extends StatelessWidget {
  const EndDrawerListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EndDrawerListTile(
          icon: Icons.star_border_rounded,
          text: "Reviews",
          route: 'ReviewPage()', // HERE
        ),
        EndDrawerListTile(
          icon: Icons.newspaper_rounded,
          text: "News",
          route: 'NewsPage()', // HERE
        ),
        EndDrawerListTile(
          icon: Icons.work_outline,
          text: "Jobs",
          route: 'JobPage()', // HERE
        ),
        EndDrawerListTile(
          icon: Icons.people_alt_outlined,
          text: "Friends",
          route: '/',
        ),
        EndDrawerListTile(
          icon: Icons.military_tech_outlined,
          text: "Rank",
          route: 'RankPage()', // HERE
        ),
        EndDrawerListTile(
          icon: Icons.settings_outlined,
          text: "Settings",
          route: 'SettingPage()', // HERE
        ),
      ],
    );
  }
}
