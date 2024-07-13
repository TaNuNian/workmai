import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/search_tab.dart';
import 'package:workmai/src/decor/textfield_decor.dart';
import 'package:workmai/src/main_pages/news_page/news_tile.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final TextEditingController _textEditingController;

  final List<String> newsList = [
    'a',
    'bb',
    'ccc',
    'dddd',
  ];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appbar(context),
      body: _body(context),
    );
  }

  _appbar(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.25,
      decoration: const BoxDecoration(
        color: Color(0xff327B90),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Text
            Row(
              children: [
                BackButton(
                  color: const Color(0xffFFFFFF),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'NEWS',
                  style: GoogleFonts.raleway(
                    color: const Color(0xffFFFFFF),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      bottom: 30,
                      right: 20,
                    ),
                    child: CustomSearchTab(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: textfieldSearchDec('Search'),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    size: 32,
                    color: Color(0xffFFFFFF),
                  ),
                  onPressed: () {}, // TODO: Filter News
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _appbar(context),
          Padding(
            padding: const EdgeInsets.all(8),
            child: _listNews(context),
          ),
        ],
      ),
    );
  }

  _listNews(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final news = newsList[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: NewsTile(newsTitle: news[index], detail: 'aaa',),
        );
      },
      itemCount: newsList.length,
    );
  }
}
