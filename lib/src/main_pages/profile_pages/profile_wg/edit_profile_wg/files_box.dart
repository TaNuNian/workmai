import 'package:flutter/material.dart';

class FilesBox extends StatefulWidget {
  final Widget? child;

  const FilesBox({
    super.key,
    this.child,

  });

  @override
  _FilesBoxState createState() => _FilesBoxState();
}

class _FilesBoxState extends State<FilesBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120 / 0.5,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffB6E7D3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: widget.child ?? Container()),
    );
  }
}
