import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/src/decor/tags.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/tags_search_bar/search_bar.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/tags_search_bar/tag_list.dart';

class SelectTagsPage extends StatefulWidget {
  final bool isInterested;

  const SelectTagsPage({super.key, required this.isInterested});

  @override
  _SelectTagsPageState createState() => _SelectTagsPageState();
}

class _SelectTagsPageState extends State<SelectTagsPage> {
  final TextEditingController _searchController = TextEditingController();
  late Map<String, dynamic> allTags;
  Map<String, dynamic> filteredTags = {};
  Map<String, String> selectedTags = {};
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    allTags = widget.isInterested ? interests : skills;
    filteredTags = allTags;
    _searchController.addListener(_filterTags);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTags() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      isSearching = query.isNotEmpty;
      filteredTags = {};

      allTags.forEach((category, tags) {
        final matchingTags = _filterSubTags(tags, query);
        if (matchingTags.isNotEmpty || category.toLowerCase().contains(query)) {
          filteredTags[category] = matchingTags.isNotEmpty ? matchingTags : tags;
        }
      });

      // Ensure selected sub-tags are always included under their parent categories
      selectedTags.forEach((tag, value) {
        allTags.forEach((category, tags) {
          if (tags is List && tags.contains(tag)) {
            if (!filteredTags.containsKey(category)) {
              filteredTags[category] = [];
            }
            if (!filteredTags[category].contains(tag)) {
              filteredTags[category].add(tag);
            }
          } else if (tags is Map) {
            tags.forEach((subCategory, subTags) {
              if (subTags.contains(tag)) {
                if (!filteredTags.containsKey(category)) {
                  filteredTags[category] = {};
                }
                if (!filteredTags[category].containsKey(subCategory)) {
                  filteredTags[category][subCategory] = [];
                }
                if (!filteredTags[category][subCategory].contains(tag)) {
                  filteredTags[category][subCategory].add(tag);
                }
              }
            });
          }
        });
      });
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

  void _onTagTap(String tag, String? value) {
    setState(() {
      if (selectedTags.containsKey(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags[tag] = value ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isInterested ? 'Select Interested Tags' : 'Select Skill Tags'),
        backgroundColor: const Color(0xff327B90),
      ),
      body: Padding(
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
                    selectedInterest: selectedTags,
                    onTagTap: _onTagTap,
                    isFromInter: widget.isInterested,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedTags.keys.toList());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff327B90),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'DONE',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
