import 'package:flutter/material.dart';
import 'package:workmai/src/decor/search_tab.dart';

class SearchTagsBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchTagsBar(
      {super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomSearchTab(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Color(0xFF80CBC4)),
          hintText: 'Search Tags',
          hintStyle: const TextStyle(color: Color(0xFF80CBC4)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
