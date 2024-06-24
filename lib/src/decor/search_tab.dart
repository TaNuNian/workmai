import 'package:flutter/material.dart';

class CustomSearchTab extends StatelessWidget {
  Widget? child;

  CustomSearchTab({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(child: child),
      ),
    );
  }
}
