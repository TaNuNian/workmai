import 'package:flutter/cupertino.dart';

const LinearGradient mainLinearGradient = LinearGradient(
  colors: [
    Color(0xffA6EDD1),
    Color(0xff59A1B6),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.0, 100],
);

const LinearGradient mainLinearGradientReverse = LinearGradient(
  colors: [
    Color(0xff59A1B6),
    Color(0xffA6EDD1),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.0, 100],
);

const LinearGradient crossLinearGradient = LinearGradient(
  colors: [
    Color(0xff59A1B6),
    Color(0xffA6EDD1),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: [0.0, 100],
);