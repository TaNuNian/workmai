import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double thickness;

  const CustomDivider({super.key, required this.thickness});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.05,
      ),
      child: Divider(
        thickness: thickness,
        color: const Color(0xff59A1B6),
      ),
    );
  }
}
