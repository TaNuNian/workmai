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
          // route: ReviewPage(),
        ),
        EndDrawerListTile(
          icon: Icons.newspaper_rounded,
          text: "News",
          // route: NewsPage(),
        ),
        EndDrawerListTile(
          icon: Icons.work,
          text: "Jobs",
          // route: JobPage(),
        ),
        EndDrawerListTile(
          icon: Icons.military_tech_outlined,
          text: "Rank",
          // route: RankPage(),
        ),
        EndDrawerListTile(
          icon: Icons.settings,
          text: "Settings",
          // route: SettingPage(),
        ),
      ],
    );
  }
}
