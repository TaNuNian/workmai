import 'package:flutter/material.dart';
import 'package:workmai/src/decor/tags.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/create_acc_inter/create_acc_inter_box.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/tags_search_bar/search_bar.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/tags_search_bar/tag_list.dart';

class CreateAccInter extends StatefulWidget {
  const CreateAccInter({super.key});

  @override
  _CreateAccInterState createState() => _CreateAccInterState();
}

class _CreateAccInterState extends State<CreateAccInter> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF5BA3B7), Color(0xFFA6EDD1)],
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  "WHICH OF THESE TOPICS ARE YOU INTERESTED IN?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            CreateAccInterBox(),
          ],
        ),
      ),
    );
  }
}
