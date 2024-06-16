import 'package:flutter/material.dart';
import 'search_bar.dart';
import 'tag_list.dart';

class TagSelectionPage extends StatefulWidget {
  final Map<String, dynamic> initialTags;
  final Map<String, String> selectedInterest; // Change bool to String

  TagSelectionPage({required this.initialTags, required this.selectedInterest});

  @override
  _TagSelectionPageState createState() => _TagSelectionPageState();
}

class _TagSelectionPageState extends State<TagSelectionPage> {
  TextEditingController _searchController = TextEditingController();
  late Map<String, dynamic> allTags;
  Map<String, dynamic> filteredTags = {};
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

  void _onTagTap(String tag, String? value) {
    setState(() {
      widget.selectedInterest[tag] = value ?? '';
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
          onTagTap: _onTagTap,
        ),
      ],
    );
  }
}
