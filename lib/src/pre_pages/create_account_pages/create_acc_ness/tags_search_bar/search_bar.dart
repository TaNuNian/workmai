import 'package:flutter/material.dart';

class SearchTagsBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  SearchTagsBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Search Tags',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: onChanged,
    );
  }
}
