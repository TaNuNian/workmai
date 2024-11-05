import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  final String? type;

  const NewsPage({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: const Color(0xffD9D9D9),
                  child: Text(
                    type ?? 'Type'
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
