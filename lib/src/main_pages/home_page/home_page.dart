import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/gradients.dart';
import 'package:workmai/src/decor/padding.dart';

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
                maxHeight: MediaQuery.sizeOf(context).height * 0.35,
              ),
              decoration: const BoxDecoration(
                gradient: mainLinearGradient,
              ),
            ),

            // Body
            SafeArea(
              child: Padding(
                padding: bodyHomePagePadding(context),
                child: Container(
                  color: Colors.brown,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'HOME',
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            color: Colors.black12,
                            child: Row(
                              children: [

                                // Inbox
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '');
                                  },
                                  icon: const Icon(
                                    Icons.inbox,
                                    size: 36,
                                  ),
                                ),

                                // End-Drawer
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '');
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                    size: 36,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
