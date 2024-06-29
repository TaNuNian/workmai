import 'package:flutter/material.dart';

class TagList extends StatefulWidget {
  final Map<String, dynamic> tags;
  final Map<String, String> selectedInterest;
  final void Function(String, String?) onTagTap;
  final bool isFromInter;

  const TagList({
    super.key,
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
    // แท็กที่เลือกไว้ก่อนหน้า
    final selectedTags = widget.selectedInterest.keys.toList();
    // แท็กที่ค้นหา โดยกรองเอาแท็กที่เลือกแล้วออก
    final searchTags = widget.tags.keys
        .where((category) => !_containsSelectedTags(widget.tags[category]))
        .toList();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // แสดงแท็กที่เลือกไว้ก่อนหน้า
        if (selectedTags.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Selected Tags',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ...selectedTags.map((tag) => _buildTagItem(tag, isSelected: true)).toList(),
          const SizedBox(height: 16), // เพิ่มระยะห่างระหว่างส่วนของแท็กที่เลือกและแท็กที่ยังไม่เลือก
        ],
        // แสดงแท็กที่ค้นหา
        ...searchTags.map((category) {
          return _buildExpansionTile(category, widget.tags[category]);
        }).toList(),
      ],
    );
  }

  bool _containsSelectedTags(dynamic tags) {
    if (tags is List) {
      return tags.every((tag) => widget.selectedInterest.containsKey(tag));
    } else if (tags is Map) {
      return tags.values.every((subTags) => _containsSelectedTags(subTags));
    }
    return false;
  }

  Widget _buildExpansionTile(String title, dynamic subTags, {int depth = 0}) {
    final padding = EdgeInsets.only(left: depth * 16.0);
    final isExpanded = expandedCategories[title] ?? false;

    if (subTags is List) {
      final visibleSubTags = subTags.where((tag) => !widget.selectedInterest.containsKey(tag)).toList();
      if (visibleSubTags.isEmpty) return Container();

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
                trailing: widget.selectedInterest.containsKey(title)
                    ? const Icon(Icons.radio_button_checked)
                    : const Icon(Icons.radio_button_unchecked),
                onTap: () {
                  setState(() {
                    if (widget.selectedInterest.containsKey(title)) {
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
          if (isExpanded)
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                children: visibleSubTags.map<Widget>((tag) {
                  return _buildTagItem(tag);
                }).toList(),
              ),
            ),
        ],
      );
    } else if (subTags is Map) {
      final visibleSubCategories = subTags.keys
          .where((subCategory) => !_containsSelectedTags(subTags[subCategory]))
          .toList();
      if (visibleSubCategories.isEmpty) return Container();

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                trailing: widget.selectedInterest.containsKey(title)
                    ? const Icon(Icons.radio_button_checked)
                    : const Icon(Icons.radio_button_unchecked),
                onTap: () {
                  setState(() {
                    if (widget.selectedInterest.containsKey(title)) {
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
              children: visibleSubCategories.map<Widget>((subCategory) => _buildExpansionTile(subCategory, subTags[subCategory], depth: depth + 1)).toList(),
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

  Widget _buildTagItem(String tag, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Text(tag),
          trailing: isSelected
              ? const Icon(Icons.radio_button_checked)
              : const Icon(Icons.radio_button_unchecked),
          onTap: () {
            setState(() {
              if (widget.selectedInterest.containsKey(tag)) {
                widget.onTagTap(tag, null);
              } else {
                widget.onTagTap(tag, 'interest');
              }
            });
          },
        ),
      ),
    );
  }
}
