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
  final List<String> _wbName = [
    'AAA',
    'BBB',
    'CCC',
    'DDD',
    'EEE',
  ];

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
            const SizedBox(
              height: 12,
            ),
            Expanded(child: _list(context)),
          ],
        ),
      ),
    );
  }

  Widget _list(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: double.infinity,
                        color: const Color(0xffD9D9D9),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _wbName[index],
                            style: GoogleFonts.raleway(
                              color: const Color(0xff327B90),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 12,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'by',
                                style: GoogleFonts.raleway(
                                  color: const Color(0xff6DD484),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'NAME',
                                style: GoogleFonts.raleway(
                                  color: const Color(0xffB8E175),
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
      itemCount: _wbName.length,
    );
  }
}
