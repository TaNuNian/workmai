import 'package:flutter/material.dart';

class TagList extends StatefulWidget {
  final Map<String, dynamic> tags;
  final Map<String, String> selectedInterest;
  final void Function(String, String?) onTagTap;
  final bool isFromInter;

  TagList({
    required this.tags,
    required this.selectedInterest,
    required this.onTagTap,
    required this.isFromInter,
  });

  @override
  _TagListState createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  Map<String, bool> expandedCategories = {};

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: widget.tags.keys.map((category) {
        return _buildExpansionTile(category, widget.tags[category]);
      }).toList(),
    );
  }

  Widget _buildExpansionTile(String title, dynamic subTags, {int depth = 0}) {
    final padding = EdgeInsets.only(left: depth * 16.0);
    final isExpanded = expandedCategories[title] ?? false;

    if (subTags is List) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: depth == 0 ? 18 : 16,
                    fontWeight: depth == 0 ? FontWeight.bold : FontWeight.normal,
                    color: Colors.black54,
                  ),
                ),
                trailing: Radio<String>(
                  value: title,
                  groupValue: widget.selectedInterest[title],
                  onChanged: (String? value) {
                    setState(() {
                      if (widget.selectedInterest[title] == value) {
                        widget.onTagTap(title, null);
                        expandedCategories[title] = false;
                      } else {
                        widget.onTagTap(title, value);
                        expandedCategories[title] = true;
                      }
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    if (widget.selectedInterest[title] == title) {
                      widget.onTagTap(title, null);
                      expandedCategories[title] = false;
                    } else {
                      widget.onTagTap(title, title);
                      expandedCategories[title] = true;
                    }
                  });
                },
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Column(
              children: subTags.map<Widget>((tag) => _buildRadioListTile(tag, depth + 1)).toList(),
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      );
    } else if (subTags is Map) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: depth == 0 ? 18 : 16,
                    fontWeight: depth == 0 ? FontWeight.bold : FontWeight.normal,
                    color: Colors.black54,
                  ),
                ),
                trailing: Radio<String>(
                  value: title,
                  groupValue: widget.selectedInterest[title],
                  onChanged: (String? value) {
                    setState(() {
                      if (widget.selectedInterest[title] == value) {
                        widget.onTagTap(title, null);
                        expandedCategories[title] = false;
                      } else {
                        widget.onTagTap(title, value);
                        expandedCategories[title] = true;
                      }
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    if (widget.selectedInterest[title] == title) {
                      widget.onTagTap(title, null);
                      expandedCategories[title] = false;
                    } else {
                      widget.onTagTap(title, title);
                      expandedCategories[title] = true;
                    }
                  });
                },
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Column(
              children: subTags.keys.map<Widget>((subCategory) => _buildExpansionTile(subCategory, subTags[subCategory], depth: depth + 1)).toList(),
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildRadioListTile(String ability, int depth) {
    final padding = EdgeInsets.only(left: depth * 16.0);
    return Padding(
      padding: padding,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Text(ability),
          trailing: Radio<String>(
            value: ability,
            groupValue: widget.selectedInterest[ability],
            onChanged: (String? value) {
              setState(() {
                if (widget.selectedInterest[ability] == value) {
                  widget.onTagTap(ability, null);
                } else {
                  widget.onTagTap(ability, value);
                }
              });
            },
          ),
          onTap: () {
            setState(() {
              if (widget.selectedInterest[ability] == ability) {
                widget.onTagTap(ability, null);
              } else {
                widget.onTagTap(ability, ability);
              }
            });
          },
        ),
      ),
    );
  }
}
