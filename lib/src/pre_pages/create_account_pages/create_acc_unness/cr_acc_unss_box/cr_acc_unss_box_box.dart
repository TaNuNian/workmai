import 'package:flutter/material.dart';

class CrAccUnssBoxBox extends StatelessWidget {
  final Widget? child;

  const CrAccUnssBoxBox({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12), // เพิ่ม padding ให้กับ Container
      decoration: BoxDecoration(
        color: const Color(0xffE5F1D3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
