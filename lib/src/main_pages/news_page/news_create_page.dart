import 'package:flutter/material.dart';

class NewsCreatePage extends StatefulWidget {
  const NewsCreatePage({super.key});

  @override
  _NewsCreatePageState createState() => _NewsCreatePageState();
}

class _NewsCreatePageState extends State<NewsCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(
              Icons.save_outlined,
              size: 32,
              color: Color(0xff327B90),
            ),
          ),
        )

      ],
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(child: Column(children: [],));
  }
}
