import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmai/model/profile_provider.dart';
import 'package:workmai/src/decor/tags.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/tags_search_bar/search_bar.dart';
import 'package:workmai/src/pre_pages/create_account_pages/create_acc_ness/tags_search_bar/tag_list.dart';

class CreateAccSkillProvider extends StatefulWidget {
  const CreateAccSkillProvider({super.key});

  @override
  State<CreateAccSkillProvider> createState() => _CreateAccSkillProviderState();
}

class _CreateAccSkillProviderState extends State<CreateAccSkillProvider> {
  Map<String, String> selectedSkills = {};

  final TextEditingController _searchController = TextEditingController();
  late Map<String, dynamic> allTags;
  Map<String, dynamic> filteredTags = {};
  bool isSearching = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    allTags = skills;
    filteredTags = allTags;
    _searchController.addListener(_filterTags);
    _focusNode.unfocus();
  }

  List<String> _convertSelectedSkillsToList() {
    return selectedSkills.values.where((value) => value != '').toList();
  }

  void _filterTags() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      isSearching = query.isNotEmpty;
      filteredTags = {};

      // ค้นหาแท็กตามเงื่อนไขการค้นหา
      allTags.forEach((category, tags) {
        final matchingTags = _filterSubTags(tags, query);
        if (matchingTags.isNotEmpty || category.toLowerCase().contains(query)) {
          filteredTags[category] = matchingTags.isNotEmpty ? matchingTags : tags;
        }
      });

      // Ensure selected sub-tags are always included under their parent categories
      selectedSkills.forEach((tag, value) {
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
        if (matchingSubTags.isNotEmpty ||
            subCategory.toLowerCase().contains(query)) {
          filteredSubTags[subCategory] =
              matchingSubTags.isNotEmpty ? matchingSubTags : subTags;
        }
      });
      return filteredSubTags;
    } else {
      return [];
    }
  }

  void _onTagTap(String tag, String? value) {
    setState(() {
      if (selectedSkills.containsKey(tag)) {
        selectedSkills.remove(tag);
      } else {
        selectedSkills[tag] = value ?? '';
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
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Padding(
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
                  isFromInter: true,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                final selectedValues = _convertSelectedSkillsToList();
                print('Selected Values: $selectedValues');
                profileProvider.setSkilledTags(selectedValues);
                Navigator.pushNamed(
                    context, '/create-acc-unness-intro');
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
    );
  }
}
