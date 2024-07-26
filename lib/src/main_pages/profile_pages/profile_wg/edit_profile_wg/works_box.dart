import 'package:flutter/material.dart';

class WorksBox extends StatefulWidget {
  final Widget? child;

  const WorksBox({
    super.key,
    required this.child,
  });

  @override
  _WorksBoxState createState() => _WorksBoxState();
}

class _WorksBoxState extends State<WorksBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200 / 0.5,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffECECEC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: widget.child ?? Container()),
    );
  }
}
