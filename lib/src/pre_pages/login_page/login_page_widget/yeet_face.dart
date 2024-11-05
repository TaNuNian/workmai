import 'package:flutter/material.dart';

class YeetFace extends StatelessWidget {
  const YeetFace({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      width: width,
      height: height * 0.3,
      child: Image.asset('lib/assets/yeet_face.png'),
    );
  }
}
