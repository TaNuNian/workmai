import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BbgenWorkChatSetting extends StatelessWidget {
  BbgenWorkChatSetting({super.key});

  final List<String> skilledTags = [];
  final List<String> interestedTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _body(context),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Work Name',
        style: GoogleFonts.raleway(
          color: const Color(0xff327B90),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xffEFFED5),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Useful tools
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: _tools(context),
          ),
          const SizedBox(height: 16),
          Container(
            color: const Color(0xffEFFED5),
            child: _chatSettingMenu(context),
          ),
          // TERMINATE Button
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'TERMINATE',
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tools(BuildContext context) {
    return Container(
      color: const Color(0xffEFFED5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Work Plan',
                    style: GoogleFonts.raleway(
                      color: const Color(0xff327B90),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add, size: 24,),)
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Milestones(),
          ],
        ),
      ),
    );
  }

  Widget _chatSettingMenu(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
        horizontal: MediaQuery.of(context).size.width * 0.02,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: GoogleFonts.raleway(
                    color: const Color(0xff327B90),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xffA6EDD1),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}

class Milestones extends StatelessWidget {
  const Milestones({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Point ${index + 1}'),
            tileColor: const Color(0xffffffff),
          ),
        );
      },
    );
  }
}
