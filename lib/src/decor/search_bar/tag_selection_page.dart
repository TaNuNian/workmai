import 'package:flutter/material.dart';
import 'search_bar.dart';
import 'tag_list.dart';

class TagSelectionPage extends StatefulWidget {
  final Map<String, List<String>> initialTags;
  final Map<String, bool> selectedInterest;

  TagSelectionPage({required this.initialTags, required this.selectedInterest});

  @override
  _TagSelectionPageState createState() => _TagSelectionPageState();
}

class _TagSelectionPageState extends State<TagSelectionPage> {
  TextEditingController _searchController = TextEditingController();
  late Map<String, List<String>> allTags;
  Map<String, List<String>> filteredTags = {};
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    allTags = widget.initialTags;
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
          final matchingTags = tags.where((tag) => tag.toLowerCase().contains(query)).toList();
          if (matchingTags.isNotEmpty) {
            filteredTags[category] = matchingTags;
          }
        });
      } else {
        filteredTags = allTags;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchTagsBar(
          controller: _searchController,
          onChanged: (query) => _filterTags(),
        ),
        const SizedBox(height: 16),
        TagList(
          tags: filteredTags,
          selectedInterest: widget.selectedInterest,
        ),
      ],
    );
  }
}
