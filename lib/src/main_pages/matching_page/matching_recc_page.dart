import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workmai/src/main_pages/matching_page/startmatchbutton.dart';
import 'dart:math';

class MatchingReccPage extends StatefulWidget {
  MatchingReccPage({super.key});

  @override
  State<MatchingReccPage> createState() => _MatchingReccPageState();
}

class _MatchingReccPageState extends State<MatchingReccPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> categories = [];
  String? selectedCategory;
  List<Map<String, dynamic>> userList = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('category').doc('tags').get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        List<String> interested = data['interested'].keys.toList();
        List<String> skilled = data['skilled'].keys.toList();
        Set<String> uniqueCategories = {...interested, ...skilled};
        setState(() {
          categories = uniqueCategories.toList();

        });

        // If no category selected, randomly pick one
        if (selectedCategory == null && categories.isNotEmpty) {
          selectedCategory = categories[Random().nextInt(categories.length)];
          fetchUsersByCategory(selectedCategory!);
        }
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> fetchUsersByCategory(String category) async {
    List<String> uids = [];
    List<Map<String, dynamic>> users = [];

    try {
      DocumentSnapshot doc = await _firestore.collection('category').doc('tags').get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        if (data['interested'][category] != null) {
          uids.addAll(List<String>.from(data['interested'][category]));
        }
        if (data['skilled'][category] != null) {
          uids.addAll(List<String>.from(data['skilled'][category]));
        }
        uids = uids.toSet().toList(); // Remove duplicates

        for (String uid in uids) {
          Map<String, dynamic>? userData = await fetchFriendData(uid);
          if (userData != null) {
            users.add(userData);
          }
        }

        setState(() {
          userList = users;
        });
      }
    } catch (e) {
      print('Error fetching users by category: $e');
    }
  }

  Future<Map<String, dynamic>?> fetchFriendData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return {
        'uid': uid,
        'name': data['profile']['name'],
        'displayName': data['profile']['display_name'],
        'profilePicture': data['profile']['profilePicture'],
        'aboutme': data['profile']['aboutme'],
      };
    } catch (e) {
      print('Error fetching friend data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xff59A1B6).withOpacity(0.6),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: const Color(0xff327B90),
      ),
      body: _body(context),
    );
  }

  Widget _appbar(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 240,
      decoration: const BoxDecoration(
          color: Color(0xff327B90),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Text
            Text(
              'FIND YOUR CO-WORKERS',
              style: GoogleFonts.raleway(
                color: const Color(0xffFFFFFF),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 30, bottom: 30, right: 20),
                    child: startMatchButton(context, '/match-result-page'),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffE5F1D3),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 32,
                    ),
                    onPressed: () {}, // TODO: Search Button
                  ),
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
          _categoryDropdown(context),
          Expanded(child: _listRecomended(context)),
        ],
      ),
    );
  }

  Widget _categoryDropdown(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, top: 12, bottom: 12),
          child: DropdownButton<String>(
            value: selectedCategory,
            hint: Text(
              'Category',
              style: GoogleFonts.raleway(
                color: const Color(0xff327B90),
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            items: categories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue;
              });
              fetchUsersByCategory(newValue!);
            },
          ),
        ),
      ],
    );
  }

  Widget _listRecomended(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: List.generate(
            userList.length,
                (index) {
              return _listCard(context, userList[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _listCard(BuildContext context, Map<String, dynamic> user) {
    return Container(
      width: (MediaQuery.of(context).size.width - 64) / 2,
      decoration: BoxDecoration(
        color: const Color(0xff67B4CA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            backgroundImage: user['profilePicture'] != null
                ? NetworkImage(user['profilePicture'])
                : null,
            child: user['profilePicture'] == null
                ? Icon(Icons.person, size: 40)
                : null,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['displayName'] ?? 'Unknown',
                  style: GoogleFonts.raleway(
                    color: const Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '@${user['name'] ?? 'username'}',
                  style: GoogleFonts.raleway(
                    color: const Color(0xffffffff),
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff2A4B54),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        user['aboutme'] ?? '',
                        style: GoogleFonts.raleway(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
