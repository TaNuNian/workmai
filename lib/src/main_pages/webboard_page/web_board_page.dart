import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/padding.dart';
import 'package:workmai/src/decor/search_tab.dart';
import 'package:workmai/src/decor/textfield_decor.dart';

class WebBoardPage extends StatefulWidget {
  const WebBoardPage({super.key});

  @override
  _WebBoardPageState createState() => _WebBoardPageState();
}

class _WebBoardPageState extends State<WebBoardPage> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  _appbar(BuildContext context) {
    return AppBar(
      title: const Text('Web Board'),
      titleTextStyle: GoogleFonts.raleway(
        color: const Color(0xff327B90),
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
    );
  }

  _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            CustomSearchTab(
              child: TextField(
                controller: _textEditingController,
                decoration: textfieldSearchDec('Search'),
              ),
            ),
            
            _list(context),
          ],
        ),
      ),
    );
  }

  _list(BuildContext context) {
    return ;
  }
}
