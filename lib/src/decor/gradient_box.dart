import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workmai/src/decor/gradients.dart';

class GradientBox extends StatelessWidget {
 final double height;
  const GradientBox({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: height,
      decoration: BoxDecoration(
        gradient: mainLinearGradient,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
