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

  TextEditingController _searchController = TextEditingController();
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
  } // TODO น่าจะตรงนี้นะ ที่ error

  void _filterTags() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      isSearching = query.isNotEmpty;
      if (isSearching) {
        filteredTags = {};
        allTags.forEach((category, tags) {
          final matchingTags = _filterSubTags(tags, query);
          if (matchingTags.isNotEmpty ||
              category.toLowerCase().contains(query)) {
            filteredTags[category] =
                matchingTags.isNotEmpty ? matchingTags : tags;
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

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SearchTagsBar(
            controller: _searchController,
            onChanged: (query) => _filterTags(),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
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
                print(
                    'Selected interests: ${profileProvider.profile.interested_tags} and Selected skills: ${profileProvider.profile.skilled_tags}');
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
    );
  }
}
