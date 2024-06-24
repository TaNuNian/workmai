import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';
import 'package:workmai/src/decor/padding.dart';
import 'package:workmai/src/main_pages/home_page/home_page_wg/home_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            // background Gradient Box
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.45,
              ),
              decoration: BoxDecoration(
                gradient: mainLinearGradient,
                borderRadius: BorderRadius.circular(20)
              ),
            ),

            // Body
            const HomePageBody(),
          ],
        ),
      ),
    );
  }
}
