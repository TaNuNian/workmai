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
          route: '/review-page', // HERE
        ),
        EndDrawerListTile(
          icon: Icons.newspaper_rounded,
          text: "News",
          route: '/news-page-list', // HERE
        ),
        // EndDrawerListTile(
        //   icon: Icons.work_outline,
        //   text: "Jobs",
        //   route: '', // HERE
        // ),
        EndDrawerListTile(
          icon: Icons.people_alt_outlined,
          text: "Friends",
          route: '/friend-list',
        ),
        EndDrawerListTile(
          icon: Icons.military_tech_outlined,
          text: "Rank",
          route: '/rank-page', // HERE
        ),
        EndDrawerListTile(
          icon: Icons.settings_outlined,
          text: "Settings",
          route: '/settings-page', // HERE
        ),
        // EndDrawerListTile(
        //   icon: Icons.logout_outlined,
        //   text: "Log Out",
        //   route: '/login2', // HERE
        // ),
      ],
    );
  }
}
