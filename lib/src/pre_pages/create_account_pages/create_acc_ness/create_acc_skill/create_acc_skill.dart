import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/decor/tags.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/tags_search_bar/search_bar.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/tags_search_bar/tag_list.dart';

class CreateAccSkill extends StatefulWidget {
  const CreateAccSkill({super.key});

  @override
  _CreateAccSkillState createState() => _CreateAccSkillState();
}

class _CreateAccSkillState extends State<CreateAccSkill> {
  Map<String, String> selectedSkills = {};

  final TextEditingController _searchController = TextEditingController();
  late Map<String, dynamic> allTags;
  Map<String, dynamic> filteredTags = {};
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    allTags = skills;
    filteredTags = allTags;
    _searchController.addListener(_filterTags);
  }

  void _filterTags() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      isSearching = query.isNotEmpty;
      if (isSearching) {
        filteredTags = {};
        allTags.forEach((category, tags) {
          final matchingTags = _filterSubTags(tags, query);
          if (matchingTags.isNotEmpty || category.toLowerCase().contains(query)) {
            filteredTags[category] = matchingTags.isNotEmpty ? matchingTags : tags;
          }
        });
      } else {
        filteredTags = allTags;
      }
    });
  }

  dynamic _filterSubTags(dynamic tags, String query) {
    if (tags is List) {
      return tags.where((tag) => tag.toLowerCase().contains(query)).toList();
    } else if (tags is Map) {
      final filteredSubTags = {};
      tags.forEach((subCategory, subTags) {
        final matchingSubTags = _filterSubTags(subTags, query);
        if (matchingSubTags.isNotEmpty || subCategory.toLowerCase().contains(query)) {
          filteredSubTags[subCategory] = matchingSubTags.isNotEmpty ? matchingSubTags : subTags;
        }
      });
      return filteredSubTags;
    } else {
      return [];
    }
  }
  List<String> _convertSelectedSkillsToList() {
    return selectedSkills.values.where((value) => value != '').toList();
  }
  void _onTagTap(String tag, String? value) {
    setState(() {
      selectedSkills[tag] = value ?? '';
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final List<String> selectedInter = ModalRoute.of(context)!.settings.arguments as List<String>;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "WHAT ABILITIES DO YOU HAVE?",
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SearchTagsBar(
                          controller: _searchController,
                          onChanged: (query) => _filterTags(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0F2F1),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            child: TagList(
                              tags: filteredTags,
                              selectedInterest: selectedSkills,
                              onTagTap: _onTagTap,
                              isFromInter: false,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            final selectedValues = _convertSelectedSkillsToList();
                            profileProvider.setSkilledTags(selectedValues);
                            profileProvider.setInterestedTags(selectedInter);
                            print('Selected interests: ${profileProvider.profile.interested_tags} and Selected skills: ${profileProvider.profile.skilled_tags}');
                            print('${profileProvider.profile.name}');
                            Navigator.pushNamed(context, '/create-acc-unness-intro');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF80CBC4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("CONTINUE"),
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
