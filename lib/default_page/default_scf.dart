import 'package:flutter/material.dart';
import 'package:workmai/src/custom_appbar/custom_appbar.dart';
import 'package:workmai/src/decor/padding.dart';


class DefaultScf extends StatelessWidget {

  final Widget child;
  final Color? appbarColor;

  final Color? backColor;
  final Color? backgroundColor;

  const DefaultScf(
      {super.key, required this.child, this.appbarColor, this.backColor, this.backgroundColor,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? const Color(0xffffffff),
      appBar: CustomAppbar(
        appbarColor: appbarColor ?? Colors.transparent,
        backColor: const Color(0xff60a8b9),
      ),
      body: SafeArea(
        child: Padding(
          padding: bodyPadding(context),
          child: child,
        ),
      ),
    );
  }
}