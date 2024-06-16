import 'package:flutter/material.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/tags_search_bar/tag_selection_page.dart';

class CreateAccInter extends StatefulWidget {
  const CreateAccInter({super.key});

  @override
  _CreateAccInterState createState() => _CreateAccInterState();
}

class _CreateAccInterState extends State<CreateAccInter> {
  Map<String, String> selectedInterest = {};
  Map<String, dynamic> interests = {
    'Category 1': {
      'Interest 1.1': {
        'Interest 1.1.1': [],
        'Interest 1.1.2': [],
      },
      'Interest 1.2': [],
      'Interest 1.3': [],
    },
    'Category 2': ['Interest 2.1', 'Interest 2.2'],
    'Category 3': ['Interest 3.1', 'Interest 3.2', 'Interest 3.3'],
  };

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFA8E6CF), Color(0xFFDCEDC1)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "WHICH OF THESE TOPICS ARE YOU INTERESTED IN?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE0F2F1),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            child: TagSelectionPage(
                              initialTags: interests,
                              selectedInterest: selectedInterest,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/create-acc-unness-intro');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF80CBC4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text("CONTINUE"),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16), // ขยับปุ่ม CONTINUE ขึ้น
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
