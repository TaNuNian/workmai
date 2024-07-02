import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color? appbarColor;
  final Color? backColor;

  const CustomAppbar({super.key, this.appbarColor, this.backColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appbarColor ?? const Color(0xffEEECEC),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_sharp),
        iconSize: 36,
        onPressed: () {
          Navigator.pop(context);
        },
        color: backColor ?? const Color(0xffffffff),
      ),
      // title: Text(
      //     'MQ / kT: ${(MediaQuery.sizeOf(context).height * 0.1).toDouble().floor()} / ${const Size.fromHeight(kToolbarHeight).toString()}'),
    );
  }

  @override
  Size get preferredSize => _getSize();

  _getSize() {
    if (NavigationService.navigatorKey.currentContext == null) {
      return const Size.fromHeight(kToolbarHeight);
    }
    return Size.fromHeight(
        MediaQuery.sizeOf(NavigationService.navigatorKey.currentContext!)
                .height *
            0.1);
  }
}
