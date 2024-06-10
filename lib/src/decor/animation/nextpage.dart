import 'package:flutter/material.dart';

class Nextpage extends StatefulWidget {
  const Nextpage({super.key});

  @override
  _NextpageState createState() => _NextpageState();
}

class _NextpageState extends State<Nextpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
