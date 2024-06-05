import 'package:flutter/material.dart';

List<double> screenDimension(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  double height = MediaQuery.sizeOf(context).height;
  return [width, height];
}

EdgeInsets bodyPadding(BuildContext context) {
  List<double> dimensions = screenDimension(context);
  double width = dimensions[0];
  double height = dimensions[1];
  return EdgeInsets.symmetric(
    horizontal: width * 0.05,
    vertical: height * 0.02,
  );
}

EdgeInsets appbarPadding(BuildContext context) {
  List<double> dimensions = screenDimension(context);
  double width = dimensions[0];
  double height = dimensions[1];
  return EdgeInsets.symmetric(
    horizontal: width * 0.02,
    vertical: height * 0.02,
  );
}
EdgeInsets appbarLeadingPadding(BuildContext context) {
  List<double> dimensions = screenDimension(context);
  double width = dimensions[0];
  return EdgeInsets.symmetric(
    horizontal: width * 0.05,
    vertical: 0,
  );
}