import 'package:flutter/material.dart';
import 'package:workmai/src/decor/search_bar/tag_selection_page.dart';

class CreateAccInter extends StatefulWidget {
  const CreateAccInter({super.key});

  @override
  _CreateAccInterState createState() => _CreateAccInterState();
}

class _CreateAccInterState extends State<CreateAccInter> {
  Map<String, bool> selectedInterest = {};
  Map<String, List<String>> interests = {
    'Category 1': ['Interest 1.1', 'Interest 1.2', 'Interest 1.3'],
    'Category 2': ['Interest 2.1', 'Interest 2.2'],
    'Category 3': ['Interest 3.1', 'Interest 3.2', 'Interest 3.3'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "WHAT ABILITIES DO YOU HAVE?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TagSelectionPage(
                initialTags: interests,
                selectedInterest: selectedInterest,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create-acc-unness-intro');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("CONTINUE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
