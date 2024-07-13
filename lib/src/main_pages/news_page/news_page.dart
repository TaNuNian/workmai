import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workmai/methods/cloud_firestore/news.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsService _newsService = NewsService();
  late final TextEditingController _textEditingController;
  String selectedCategory = 'สายวิทย์'; // Default category

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'NEWS',
        style: GoogleFonts.raleway(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xff327B90),
      elevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildProfileSection(context),
        _buildCategoryDropdown(context),
        _buildTabBarSection(context),
        _buildTabBarViewSection(context),
      ],
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.18,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              'OH/CAMP/TrendedComp',
              style: GoogleFonts.raleway(
                color: const Color(0xff000000),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Category:',
            style: GoogleFonts.raleway(
              fontSize: 16,
              color: const Color(0xff327B90),
            ),
          ),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: selectedCategory,
            items: <String>['สายวิทย์', 'สายศิลป์'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarSection(BuildContext context) {
    return const TabBar(
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.blue,
      tabs: [
        Tab(text: 'Openhouse'),
        Tab(text: 'Camp'),
        Tab(text: 'Competition'),
      ],
    );
  }

  Widget _buildTabBarViewSection(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          _buildTabContent(context, 'openhouse'),
          _buildTabContent(context, 'camp'),
          _buildTabContent(context, 'competition'),
        ],
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, String type) {
    return FutureBuilder<QuerySnapshot>(
      future: _newsService.getNews(selectedCategory, type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No news available.'));
        }

        final news = snapshot.data!.docs;

        return ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
            final newsData = news[index].data() as Map<String, dynamic>;
            final String contentPreview = newsData['content'] != null
                ? newsData['content'].length > 100
                ? '${newsData['content'].substring(0, 100)}...'
                : newsData['content']
                : '';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xff327B90), width: 1.0), // Adding border
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newsData['title'] ?? 'No Title',
                            style: GoogleFonts.raleway(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff327B90),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            contentPreview,
                            style: GoogleFonts.raleway(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (newsData['imageUrl'] != null && newsData['imageUrl'] != '')
                      Container(
                        width: 130,
                        height: 100,
                        margin: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          image: DecorationImage(
                            image: NetworkImage(newsData['imageUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

